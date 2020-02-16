import Foundation

public extension Simctl {
  struct Device: Codable {
    public let name: String
    public let deviceTypeIdentifier: Identifier<Devicetype>

    @FilePath
    public var dataPath: URL

    @FilePath
    public var logPath: URL

    public let udid: Identifier<Device>

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
