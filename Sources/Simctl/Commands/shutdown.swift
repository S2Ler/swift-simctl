import Foundation
import Shell

extension Simctl {
  public enum ShutdownDeviceParameter: ShellArgumentConvertible {
    case all
    case deviceParam(Simctl.DeviceParameter)

    public var shellArgument: String {
      switch self {
      case .all:
        return "all"
      case .deviceParam(let deviceParameter):
        return deviceParameter.shellArgument
      }
    }
  }

  /// Shutdown device
  /// - Command docs: `xcrun simctl shutdown`
  public static func shutdown(
    _ deviceParam: ShutdownDeviceParameter
  ) async throws {
    let params: [ShellArgumentConvertible] = ["shutdown", deviceParam]

    _ = try await shell.simctl(params)
  }
}
