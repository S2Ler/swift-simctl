import Foundation
import Shell

extension Shell {
  @discardableResult
  func simctl(
    _ arguments: [ShellArgumentConvertible],
    input: Input? = nil,
    environmentVariables: [String: String]? = nil
  ) async throws -> String {
    let arguments: [ShellArgumentConvertible] = ["simctl"] + arguments
    return try await run("xcrun",
                         arguments: arguments,
                         input: input)
  }

  @discardableResult
  func simctl(
    _ simctlCommand: String,
    input: Input? = nil,
    environmentVariables: [String: String]? = nil
  ) async throws -> String {
    return try await run("xcrun simctl \(simctlCommand)", input: input)
  }

  func simctl<Value: Decodable>(
    _ arguments: [ShellArgumentConvertible],
    input: Input? = nil,
    environmentVariables: [String: String]? = nil
  ) async throws -> Value {
    let output = try await simctl(arguments, input: input)
    let decoder = JSONDecoder()
    return try decoder.decode(Value.self, from: Data(output.utf8))
  }

  func simctl<Value: Decodable>(
    _ simctlCommand: String,
    input: Input? = nil,
    environmentVariables: [String: String]? = nil
  ) async throws -> Value {
    let output = try await simctl(simctlCommand, input: input)
    let decoder = JSONDecoder()
    return try decoder.decode(Value.self, from: Data(output.utf8))
  }
}
