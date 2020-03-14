import Foundation

public typealias SimctlIdentifier<Value> = Identifier<Value, String>

public struct Identifier<Value, ID: Hashable>: Hashable, Equatable, RawRepresentable {
  public let rawValue: ID

  public init(rawValue: ID) {
    self.rawValue = rawValue
  }
}

extension Identifier: Codable where ID: Codable {
  public init(from decoder: Decoder) throws {
    rawValue = try decoder.singleValueContainer().decode(ID.self)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(rawValue)
  }
}

extension Identifier: ShellArgumentConvertible where ID == String {
  public var shellArgument: String { rawValue }
}
