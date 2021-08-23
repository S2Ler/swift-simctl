import Foundation
import Shell

extension Simctl {
  public enum DeleteDeviceParameter: ShellArgumentConvertible {
    /// Delete all devices
    case all

    /// Delete devices that are not supported by the current Xcode SDK.
    case unavailable

    /// Delete specific device
    case deviceParam(Simctl.DeviceParameter)

    public var shellArgument: String {
      switch self {
      case .all:
        return "all"
      case .unavailable:
        return "unavailable"
      case .deviceParam(let deviceParameter):
        return deviceParameter.shellArgument
      }
    }
  }

  /// Delete spcified devices, unavailable devices, or all devices.
  /// - Command docs: `xcrun simctl delete`
  public static func delete(
    _ deviceParam: DeleteDeviceParameter
  ) async throws {
    let params: [ShellArgumentConvertible] = ["delete", deviceParam]

    _ = try await shell.simctl(params)
  }
}
