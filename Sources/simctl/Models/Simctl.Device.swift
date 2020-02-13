import Foundation

public extension Simctl {
  struct Device: Codable {
    public let udid: String

    public init(udid: String) {
      self.udid = udid
    }
  }
}

extension Simctl.Device: ShellArgumentConvertible {
  var shellArgument: String { udid }
}
