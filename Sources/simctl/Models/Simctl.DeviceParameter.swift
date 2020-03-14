import Foundation

public extension Simctl {
  enum DeviceParameter {
    case booted
    case udid(SimctlIdentifier<Simctl.Device>)
    case device(Simctl.Device)
  }
}

extension Simctl.DeviceParameter: ShellArgumentConvertible {
  var shellArgument: String {
    switch self {
    case .booted: return "booted"
    case .udid(let udid): return udid.rawValue
    case .device(let device): return device.deviceTypeIdentifier.rawValue
    }
  }
}
