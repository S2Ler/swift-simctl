import Foundation
import Simctl

extension Simctl {
  static func bootedDevice() async throws -> Simctl.Device? {
    let devices = try await Simctl.listDevices(searchTerm: .availableItems)
    return devices
      .values
      .lazy
      .flatMap { $0 }
      .filter { $0.state == .booted }
      .filter { $0.name.contains("iPhone") }
      .first
  }
}
