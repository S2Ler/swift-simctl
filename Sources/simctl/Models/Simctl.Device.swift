import Foundation

public extension Simctl {
  struct Device: Codable {
    public let name: String
    public let deviceTypeIdentifier: SimctlIdentifier<Devicetype>

    @FilePath
    public var dataPath: URL

    @FilePath
    public var logPath: URL

    public let udid: SimctlIdentifier<Device>

    public let isAvailable: Bool

    public let state: String
  }
}

extension Simctl.Device: ShellArgumentConvertible {
  var shellArgument: String { udid.rawValue }
}

extension Simctl.Device: Identifiable {
  public var id: String { udid.rawValue }
}
