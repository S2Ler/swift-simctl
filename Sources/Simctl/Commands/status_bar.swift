import Foundation
import Shell

public extension Simctl {
  enum StatusBarOverride: ShellArgumentConvertible {
    case time(String)
    case dataNetwork(DataNetwork)
    case wifiMode(WiFiMode)
    case wifiBars(WiFiBars)
    case cellularMode(CellularMode)
    case cellularBars(CellularBars)
    case operatorName(String)
    case batteryState(BatteryState)
    /// Clamped to 0 to 100 range.
    case batteryLevel(Int)

    public var shellArgument: String {
      switch self {
      case .time(let time):
        return "--time \(time)"
      case .dataNetwork(let dataNetwork):
        return "--dataNetwork \(dataNetwork.shellArgument)"
      case .wifiMode(let wifiMode):
        return "--wifiMode \(wifiMode.shellArgument)"
      case .wifiBars(let bars):
        return "--wifiBars \(bars)"
      case .cellularMode(let cellularMode):
        return "--cellularMode \(cellularMode.shellArgument)"
      case .cellularBars(let cellularBars):
        return "--cellularBars \(cellularBars.shellArgument)"
      case .operatorName(let name):
        return "--operatorName \(name)"
      case .batteryState(let state):
        return "--batteryState \(state)"
      case .batteryLevel(let level):
        return "--batteryLevel \(level)"
      }
    }
  }

  // TODO: Implement status_bar list command
  //  func statusBarList() throws -> [StatusBarOverride] {
  //    preconditionFailure("Not suppo")
  //  }
  
  func statusBarClear(_ deviceParam: DeviceParameter) async throws {
    let params: [ShellArgumentConvertible] = ["shutdown", "status_bar", deviceParam, "clear"]

    _ = try await shell.simctl(params)
  }

  func statusBar(_ deviceParam: DeviceParameter, set overrides: [StatusBarOverride]) async throws {
    let params: [ShellArgumentConvertible] = [
      "shutdown",
      "status_bar",
      deviceParam,
      "override",
      overrides as [ShellArgumentConvertible]
    ]

    _ = try await shell.simctl(params)
  }
}
