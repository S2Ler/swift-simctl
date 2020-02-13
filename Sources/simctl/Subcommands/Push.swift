import Foundation

public extension Simctl {
  /// Send a simulated push notification
  /// - important: Only application remote push notifications are supported. VoIP, Complication, File Provider,
  /// and other types are not supported.
  /// - parameter bundleId: The bundle identifier of the target application.
  /// If the payload file contains a 'Simulator Target Bundle' top-level key this parameter may be omitted.
  /// If both are provided this argument will override the value from the payload.
  /// - parameter file: Path or content of a JSON payload. The payload must:
  /// Contain an object at the top level.
  /// Contain an 'aps' key with valid Apple Push Notification values.
  /// Be 4096 bytes or less.
  static func push(device: Device, bundleId: BundleId?, file: Simctl.File) throws -> String {
    var arguments: [ShellArgumentConvertible] = ["push"]

    arguments.append(device)

    if let bundleId = bundleId {
      arguments.append(bundleId)
    }

    let pipe = Pipe()

    switch file {
    case .string(let pushString):
      arguments.append("-")
      pipe.fileHandleForWriting.write(Data(pushString.utf8))
      pipe.fileHandleForWriting.closeFile()
    case .path(let fileUrl):
      precondition(fileUrl.isFileURL)
      arguments.append(fileUrl.path)
    }

    return try Shell.simctl(arguments, input: pipe.fileHandleForReading)
  }
}
