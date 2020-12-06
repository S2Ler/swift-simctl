import Foundation

public extension Simctl {
  enum DataNetwork: ShellArgumentConvertible {
    case wifi
    case threeG
    case fourG
    case lte
    case lteA
    case ltePlus

    var shellArgument: String {
      switch self {
      case .wifi:
        return "wifi"
      case .threeG:
        return "3g"
      case .fourG:
        return "4g"
      case .lte:
        return "lte"
      case .lteA:
        return "lte-a"
      case .ltePlus:
        return "lte+"
      }
    }
  }
}
