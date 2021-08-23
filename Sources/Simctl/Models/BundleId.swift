import Foundation
import Shell

public struct BundleId: Hashable, Equatable, Codable, Identifiable {
  public var rawValue: String
  public var id: String { rawValue }

  public init(_ rawValue: String) {
    self.rawValue = rawValue
  }
}

extension BundleId: CustomStringConvertible {
  public var description: String { rawValue }
}

extension BundleId: ShellArgumentConvertible {
  public var shellArgument: String { rawValue }
}
