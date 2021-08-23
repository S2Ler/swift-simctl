import XCTest
import Simctl

class SimctlListCommandTests: XCTestCase {
  func testResultIsDecodable() async throws {
    _ = try await Simctl.list()
  }

  func testRuntimesList() async throws {
    let runtimes = try await Simctl.listRuntimes()
    XCTAssert(runtimes.count > 0)
  }

  func testDeviceTypesList() async throws {
    let deviceTypes = try await Simctl.listDeviceTypes()
    XCTAssert(deviceTypes.count > 0)
  }

  func testDevicesList() async throws {
    let devices = try await Simctl.listDevices()
    XCTAssert(devices.count > 0)
  }

  func testHasValues() async throws {
    let result = try await Simctl.list()
    XCTAssert(result.devicetypes.count > 0)
    XCTAssert(result.runtimes.count > 0)
    XCTAssert(result.devices.count > 0)
  }

  func testSearchTerm() async throws {
    let searchTerm = "iPad"
    
    for (_, devices) in try await Simctl.listDevices(searchTerm: .text(searchTerm)) {
      for device in devices {
        XCTAssert(device.name.contains(searchTerm))
        XCTAssertFalse(device.name.contains("iPhone"))
      }
    }
  }

  /* timeouts on my machine */
  func _testPbCopyPaster() async throws {
    let expected = "swift-simctl"
    guard let bootedDevice = try await Simctl.bootedDevice() else {
      XCTFail(); return
    }
    print(bootedDevice.id)
    try await Simctl.pbcopy(expected, to: .device(bootedDevice))
    let devicePb = try await Simctl.pbpaste(from: .device(bootedDevice))
    XCTAssertEqual(expected, devicePb)
  }
}

