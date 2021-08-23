import Foundation
import Shell

public extension Simctl {
  /// Copy `string` to device's pasteboard
  /// - Command docs: `xcrun simctl pbcopy`
  static func pbcopy(_ string: String, to deviceParam: Simctl.DeviceParameter) async throws {
    let pipe = Pipe()
    pipe.writeAndClose(string)
    try await shell.simctl(["pbcopy", deviceParam], input: .raw(pipe))
  }
}
