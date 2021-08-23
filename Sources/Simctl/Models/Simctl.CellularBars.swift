import Foundation
import Shell

public extension Simctl {
  enum CellularBars: ShellArgumentConvertible {
    case zero
    case one
    case two
    case three
    case four

    public var shellArgument: String {
      switch self {
      case .zero:
        return "0"
      case .one:
        return "1"
      case .two:
        return "2"
      case .three:
        return "3"
      case .four:
        return "4"
      }
    }
  }
}
