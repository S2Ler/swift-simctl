import Foundation

public extension Simctl {
  enum ShutdownDeviceParameter: ShellArgumentConvertible {
    case all
    case deviceParam(Simctl.DeviceParameter)

    var shellArgument: String {
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
  static func shutdown(
    _ deviceParam: ShutdownDeviceParameter
  ) throws {
    let params: [ShellArgumentConvertible] = ["shutdown", deviceParam]

    _ = try Shell.simctl(params)
  }
}
