import Foundation

public struct Identifier<Value: Identifiable>: Hashable, Equatable, RawRepresentable {
  public let rawValue: Value.ID

  public init(rawValue: Value.ID) {
    self.rawValue = rawValue
  }
}

extension Identifier: Codable where Value.ID: Codable {
  public init(from decoder: Decoder) throws {
    rawValue = try decoder.singleValueContainer().decode(Value.ID.self)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(rawValue)
  }
}
