import Foundation
import Shell

public extension Simctl {
  /// Create a new device
  /// - Command docs: `xcrun simctl create`
  static func create(
    name: String,
    from deviceTypeId: SimctlIdentifier<Devicetype>,
    runtimeId: SimctlIdentifier<Runtime>? = nil
  ) async throws {
    var params: [ShellArgumentConvertible] = ["create", deviceTypeId]
    if let runtimeId = runtimeId {
      params.append(runtimeId)
    }
    try await shell.simctl(params)
  }
}
