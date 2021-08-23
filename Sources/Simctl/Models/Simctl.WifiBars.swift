import Foundation
import Shell

public extension Simctl {
  enum WiFiBars: ShellArgumentConvertible {
    case zero
    case one
    case two
    case three

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
      }
    }
  }
}
