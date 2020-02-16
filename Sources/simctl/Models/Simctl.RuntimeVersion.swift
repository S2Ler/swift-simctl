import Foundation

public extension Simctl {
  struct RuntimeVersion: Hashable, Equatable {
    public let rawValue: Int

    public init(_ rawValue: Int) {
      self.rawValue = rawValue
    }
  }
}

extension Simctl.RuntimeVersion: Comparable {
  public static func < (lhs: Simctl.RuntimeVersion, rhs: Simctl.RuntimeVersion) -> Bool {
    lhs.rawValue < rhs.rawValue
  }
}

extension Simctl.RuntimeVersion: Codable {
  public init(from decoder: Decoder) throws {
    rawValue = try decoder.singleValueContainer().decode(Int.self)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(rawValue)
  }
}
