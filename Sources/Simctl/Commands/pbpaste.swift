import Foundation
import Shell

extension Simctl {
  /// Returns pasteboard from device.
  /// - Command docs: `xcrun simctl list`
  public static func pbpaste(from deviceParam: DeviceParameter) async throws -> String {
    return try await shell.simctl(["pbpaste", deviceParam])
  }
}
