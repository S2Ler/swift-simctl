import Foundation
import Shell

public extension Simctl {
  enum BatteryState: ShellArgumentConvertible {
    case charging
    case charged
    case discharging

    public var shellArgument: String {
      switch self {
      case .charging:
        return "charging"
      case .charged:
        return "charged"
      case .discharging:
        return "discharging"
      }
    }
  }
}
