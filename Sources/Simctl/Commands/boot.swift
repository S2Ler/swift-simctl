import Foundation
import Shell

public extension Simctl {
  /// Boot device
  /// - Command docs: `xcrun simctl boot`
  static func boot(
    _ deviceParam: Simctl.DeviceParameter,
    disabledJobs: [String] = [],
    enabledJobs: [String] = [],
    environmentVariables: [String: String]? = nil
  ) async throws {
    func convertEnvironmentVariablesToBootedEnvironment(_ env: [String: String]) -> [String: String] {
      var result: [String: String] = [:]
      for (key, value) in env {
        result["SIMCTL_CHILD_\(key)"] = value
      }
      return result
    }

    var params: [ShellArgumentConvertible] = ["boot", deviceParam]

    for disabledJob in disabledJobs {
      params.append("--disabledJob=\(disabledJob)")
    }

    for enabledJob in enabledJobs {
      params.append("--enabledJob=\(enabledJob)")
    }

    let environmentVariables = environmentVariables.map { convertEnvironmentVariablesToBootedEnvironment($0) }

    _ = try await shell.simctl(params, environmentVariables: environmentVariables)
  }
}
