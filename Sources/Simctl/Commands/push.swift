import Foundation
import Shell

extension Simctl {
  /// Send a simulated push notification.
  /// - Command docs: `xcrun simctl push`
  /// - Returns: Command raw output.
  public static func push(
    device: Device,
    bundleId: BundleId?,
    file: Simctl.File
  ) async throws -> String {
    var arguments: [ShellArgumentConvertible] = ["push"]

    arguments.append(device)

    if let bundleId = bundleId {
      arguments.append(bundleId)
    }

    let pipe = Pipe()

    switch file {
    case .string(let pushString):
      arguments.append("-")
      pipe.writeAndClose(pushString)
    case .path(let fileUrl):
      precondition(fileUrl.isFileURL)
      arguments.append(fileUrl.path)
    }

    return try await shell.simctl(arguments, input: .raw(pipe.fileHandleForReading))
  }
}
