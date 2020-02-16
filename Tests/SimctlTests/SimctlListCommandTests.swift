import XCTest
import simctl

class SimctlListCommandTests: XCTestCase {
  func testResultIsDecodable() {
    XCTAssertNoThrow(try Simctl.list())
  }

  func testRuntimesList() throws {
    let runtimes = try Simctl.listRuntimes()
    XCTAssert(runtimes.count > 0)
  }

  func testDeviceTypesList() throws {
    let deviceTypes = try Simctl.listDeviceTypes()
    XCTAssert(deviceTypes.count > 0)
  }

  func testDevicesList() throws {
    do {
      let devices = try Simctl.listDevices()
      XCTAssert(devices.count > 0)
    }
    catch {
      XCTFail("Error: \(error)")
    }
  }

  func testHasValues() throws {
    let result = try Simctl.list()
    XCTAssert(result.devicetypes.count > 0)
    XCTAssert(result.runtimes.count > 0)
    XCTAssert(result.devices.count > 0)
  }

  func testSearchTerm() throws {
    let searchTerm = "iPad"

    for (_, devices) in try Simctl.listDevices(searchTerm: .text(searchTerm)) {
      for device in devices {
        XCTAssert(device.name.contains(searchTerm))
        XCTAssertFalse(device.name.contains("iPhone"))
      }
    }
  }
}

