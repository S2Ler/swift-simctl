import Foundation

public extension Simctl {
  /// Create a new device
  /// - Command docs: `xcrun simctl create`
  static func create(name: String,
                     from deviceTypeId: Identifier<Devicetype>,
                     runtimeId runtimeId: Identifier<Runtime>? = nil) throws {
    var params: [ShellArgumentConvertible] = ["create", deviceTypeId]
    if let runtimeId = runtimeId {
      params.append(runtimeId)
    }
    try Shell.simctl(params)
  }
}
