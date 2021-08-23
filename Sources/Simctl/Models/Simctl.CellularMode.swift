import Foundation
import Shell

public extension Simctl {
  enum CellularMode: ShellArgumentConvertible {
    case notSupported
    case searching
    case failed
    case active

    public var shellArgument: String {
      switch self {
      case .notSupported:
        return "notSupported"
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
