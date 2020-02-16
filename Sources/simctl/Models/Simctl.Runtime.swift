import Foundation

public extension Simctl {
  struct Runtime: Codable {
    public let identifier: Identifier<Runtime>

    @FilePath
    public var bundlePath: URL

    public let buildversion: String

    @FilePath
    public var runtimeRoot: URL

    public let version: String

    public let isAvailable: Bool

    public let name: String
  }
}

extension Simctl.Runtime: Identifiable {
  public var id: String { identifier.rawValue }
}
