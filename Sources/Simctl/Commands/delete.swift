import Foundation

public extension Simctl {
  enum DeleteDeviceParameter: ShellArgumentConvertible {
    /// Delete all devices
    case all

    /// Delete devices that are not supported by the current Xcode SDK.
    case unavailable

    /// Delete specific device
    case deviceParam(Simctl.DeviceParameter)

    var shellArgument: String {
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
  static func delete(
    _ deviceParam: DeleteDeviceParameter
  ) throws {
    let params: [ShellArgumentConvertible] = ["delete", deviceParam]

    _ = try Shell.simctl(params)
  }
}
