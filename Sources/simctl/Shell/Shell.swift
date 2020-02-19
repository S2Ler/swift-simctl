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

  static func run(
    command: String,
    arguments: [ShellArgumentConvertible],
    input: Any? = nil,
    environmentVariables: [String: String]? = nil
  ) throws -> String {
    let task = Process()
    task.launchPath = command
    task.arguments = arguments.map { $0.shellArgument }
    task.environment = environmentVariables

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

  @discardableResult
  static func simctl(
    _ arguments: [ShellArgumentConvertible],
    inputHandler: Any? = nil,
    environmentVariables: [String: String]? = nil
  ) throws -> String {
    let arguments: [ShellArgumentConvertible] = ["simctl"] + arguments
    return try run(command: "/usr/bin/xcrun",
                   arguments: arguments,
                   input: inputHandler)
  }

  static func simctl<Value: Decodable>(
    _ arguments: [ShellArgumentConvertible],
    inputHandler: Any? = nil,
    environmentVariables: [String: String]? = nil
  ) throws -> Value {
    let output = try simctl(arguments, inputHandler: inputHandler)
    let decoder = JSONDecoder()
    return try decoder.decode(Value.self, from: Data(output.utf8))
  }
}

extension String: ShellArgumentConvertible {
  var shellArgument: String { self }
}
