import Foundation

public extension Simctl {
  /// Copy `string` to device's pasteboard
  /// - Command docs: `xcrun simctl pbcopy`
  static func pbcopy(_ string: String, to deviceParam: Simctl.DeviceParameter) throws -> String {
    let pipe = Pipe()
    pipe.writeAndClose(string)
    return try Shell.simctl(["pbcopy", deviceParam], inputHandler: pipe)
  }
}
