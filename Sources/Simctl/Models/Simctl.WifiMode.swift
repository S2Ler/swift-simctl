import Foundation

public extension Simctl {
  enum WiFiMode: ShellArgumentConvertible {
    case searching
    case failed
    case active

    var shellArgument: String {
      switch self {
      case .searching:
        return "searching"
      case .failed:
        return "failed"
      case .active:
        return "active"
      }
    }
  }
}
