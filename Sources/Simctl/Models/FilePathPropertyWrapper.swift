import Foundation

@propertyWrapper
public struct FilePath: Codable {
  public var wrappedValue: URL

  public init(wrappedValue: URL) {
    self.wrappedValue = wrappedValue
  }

  public init(from decoder: Decoder) throws {
    let path = try decoder.singleValueContainer().decode(String.self)
    wrappedValue = URL(fileURLWithPath: path)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(wrappedValue.path)
  }
}
