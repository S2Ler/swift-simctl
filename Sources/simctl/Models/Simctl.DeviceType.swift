import Foundation

public extension Simctl {
  struct Devicetype: Codable {
    public let name: String
    public let identifier: Identifier<Self>
    public let minRuntimeVersion: RuntimeVersion
    public let maxRuntimeVersion: RuntimeVersion
    public let productFamily: String

    @FilePath
    public var bundlePath: URL
  }
}

extension Simctl.Devicetype: Identifiable {
  public var id: String { identifier.rawValue }
}
