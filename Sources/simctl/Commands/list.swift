import Foundation

public extension Simctl {
  enum List {
    /// For some reason `let devices: [Identifier<Runtime>: [Device]]` cannot be decoded for some reason.
    fileprivate struct _Result: Codable {
      let runtimes: [Runtime]
      let devicetypes: [Devicetype]

      /// Key is a Runtime identifier
      let devices: [String: [Device]]
    }

    public struct Result: Codable {
      public let runtimes: [Runtime]
      public let devicetypes: [Devicetype]
      public let devices: [SimctlIdentifier<Runtime>: [Device]]

      fileprivate init(_ result: _Result) {
        self.runtimes = result.runtimes
        self.devicetypes = result.devicetypes

        var fixedDevices: [SimctlIdentifier<Runtime>: [Device]] = [:]
        for (runtimeId, devices) in result.devices {
          fixedDevices[Identifier(rawValue: runtimeId)] = devices
        }
        self.devices = fixedDevices
      }
    }

    fileprivate enum Filter: ShellArgumentConvertible {
      case devices
      case deviceTypes
      case runtimes
      case pairs

      var shellArgument: String {
        switch self {
        case .devices: return "devices"
        case .deviceTypes: return "devicetypes"
        case .runtimes: return "runtimes"
        case .pairs: return "pairs"
        }
      }
    }

    public enum SearchTerm: ShellArgumentConvertible {
      case availableItems
      case text(String)

      var shellArgument: String {
        switch self {
        case .availableItems: return "available"
        case .text(let searchTerm): return searchTerm
        }
      }
    }
  }

  /// List available devices
  /// - Command docs: `xcrun simctl list`
  static func listDevices(searchTerm: List.SearchTerm? = nil) throws -> [SimctlIdentifier<Runtime>: [Device]] {
    struct Result: Codable {
      public let devices: [String: [Device]]
    }
    let result = (try list(filter: .devices, searchTerm: searchTerm) as Result)

    // See Simctl.List._Result why it is needed
    var fixedDevices: [SimctlIdentifier<Runtime>: [Device]] = [:]
    for (runtimeId, devices) in result.devices {
      fixedDevices[SimctlIdentifier<Runtime>(rawValue: runtimeId)] = devices
    }
    return fixedDevices
  }

  /// List available runtimes
  /// - Command docs: `xcrun simctl list --help`
  static func listRuntimes(searchTerm: List.SearchTerm? = nil) throws -> [Runtime] {
    struct Result: Codable {
      public let runtimes: [Runtime]
    }
    return (try list(filter: .runtimes, searchTerm: searchTerm) as Result).runtimes
  }

  /// List available device types
  /// - Command docs: `xcrun simctl list --help`
  static func listDeviceTypes(searchTerm: List.SearchTerm? = nil) throws -> [Devicetype] {
    struct Result: Codable {
      public let devicetypes: [Devicetype]
    }
    return (try list(filter: .deviceTypes, searchTerm: searchTerm) as Result).devicetypes
  }

  /// List available devices, device types, runtimes and device pairs.
  /// - Command docs: `xcrun simctl list --help`
  static func list() throws -> List.Result {
    let privateResult: List._Result = try Shell.simctl(["list", "-j"])
    return List.Result(privateResult)
  }

  private static func list<Value: Decodable>(filter: List.Filter, searchTerm: List.SearchTerm?) throws -> Value {
    var arguments: [ShellArgumentConvertible] = ["list", filter]
    if let searchTerm = searchTerm {
      arguments.append(searchTerm)
    }
    arguments.append("-j")
    return try Shell.simctl(arguments)
  }
}
