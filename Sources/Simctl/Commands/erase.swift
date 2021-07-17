import Foundation
import Shell

extension Simctl {
  public enum EraseDevicesParameter: ShellArgumentConvertible {
    case all
    case devices([Simctl.DeviceParameter])

    public var shellArgument: String {
      switch self {
      case .all:
        return "all"
      case .devices(let devicesParam):
        return devicesParam
          .map(\.shellArgument)
          .joined(separator: " ")
      }
    }
  }

  /// Erase a device's contents and settings.
  /// - Command docs: `xcrun simctl erase`
  public static func erase(_ devicesParam: Simctl.EraseDevicesParameter) async throws  {
    let params: [ShellArgumentConvertible] = ["erase", devicesParam]

    _ = try await shell.simctl(params)
  }
}
