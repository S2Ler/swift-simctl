import Foundation

public extension Simctl {
  /// Returns pasteboard from device.
  /// - Command docs: `xcrun simctl list`
  static func pbpaste(from deviceParam: DeviceParameter) throws -> String {
    return try Shell.simctl(["pbpaste", deviceParam])
  }
}
