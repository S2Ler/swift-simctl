import Foundation

internal protocol ShellArgumentConvertible {
  var shellArgument: String { get }
}

internal enum Shell {
  enum ShellError: LocalizedError {
    case standardError(String)
    
    var errorDescription: String? {
      switch self {
      case .standardError(let string):
        return string
      }
    }
  }

  static func run(command: String,
                  arguments: [ShellArgumentConvertible],
                  input: Any? = nil) throws -> String {
    let task = Process()
    task.launchPath = command
    task.arguments = arguments.map { $0.shellArgument }

    let outputPipe = Pipe()
    let errorPipe = Pipe()

    task.standardOutput = outputPipe
    task.standardInput = input
    task.standardError = errorPipe

    try task.run()
    let data = outputPipe.fileHandleForReading.readDataToEndOfFile()
    let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()

    guard !data.isEmpty else {
      throw ShellError.standardError(String(data: errorData, encoding: .utf8)!)
    }

    return String(data: data, encoding: .utf8) ?? ""
  }

  static func simctl(_ arguments: [ShellArgumentConvertible],
                     input: Any? = nil) throws -> String {
    let arguments: [ShellArgumentConvertible] = ["simctl"] + arguments
    return try run(command: "/usr/bin/xcrun",
                   arguments: arguments,
                   input: input)
  }
}

extension String: ShellArgumentConvertible {
  var shellArgument: String { self }
}
