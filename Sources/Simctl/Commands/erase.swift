import Foundation

public extension Simctl {
  enum EraseDevicesParameter: ShellArgumentConvertible {
    case all
    case devices([Simctl.DeviceParameter])

    var shellArgument: String {
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
  static func erase(_ devicesParam: Simctl.EraseDevicesParameter) throws  {
    let params: [ShellArgumentConvertible] = ["erase", devicesParam]

    _ = try Shell.simctl(params)
  }
}
