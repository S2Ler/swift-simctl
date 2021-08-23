import Foundation
import Shell

public extension Simctl {
  struct Device: Codable, Equatable {
    public enum State: String, Codable {
      case unknown
      case creating
      case booting
      case booted
      case shuttingDown
      case shutdown

      public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        switch rawValue {
        case "Creating":
          self = .creating
        case "Booting":
          self = .booting
        case "Booted":
          self = .booted
        case "ShuttingDown":
          self = .shuttingDown
        case "Shutdown":
          self = .shutdown
        default:
          self = .unknown
        }
      }

      public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.rawValue)
      }
    }

    public let name: String
    public let deviceTypeIdentifier: SimctlIdentifier<Devicetype>?

    @FilePath
    public var dataPath: URL

    @FilePath
    public var logPath: URL

    public let udid: SimctlIdentifier<Device>

    public let isAvailable: Bool

    public let state: State
  }
}

extension Simctl.Device: ShellArgumentConvertible {
  public var shellArgument: String { udid.rawValue }
}

extension Simctl.Device: Identifiable {
  public var id: String { udid.rawValue }
}

extension Simctl.Device: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  public static func ==(lhs: Simctl.Device, rhs: Simctl.Device) -> Bool {
    lhs.id == rhs.id
  }
}
