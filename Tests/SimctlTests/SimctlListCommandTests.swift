import XCTest
import Simctl

@_silgen_name("swift_task_runAndBlockThread")
public func runAsyncAndBlock(_ asyncFun: @escaping () async -> ())

func runThrowingAsyncAndBlock(_ asyncFun: @escaping () async throws -> ()) throws {
  var throwedError: Error?
  runAsyncAndBlock {
    do {
      try await asyncFun()
    }
    catch {
      throwedError = error
    }
  }

  if let error = throwedError {
    throw error
  }
}

class SimctlListCommandTests: XCTestCase {
  func testResultIsDecodable() throws {
    try runThrowingAsyncAndBlock {
      _ = try await Simctl.list()
    }
  }

  func testRuntimesList() throws {
    try runThrowingAsyncAndBlock {
      let runtimes = try await Simctl.listRuntimes()
      XCTAssert(runtimes.count > 0)
    }
  }

  func testDeviceTypesList() throws {
    try runThrowingAsyncAndBlock {
      let deviceTypes = try await Simctl.listDeviceTypes()
      XCTAssert(deviceTypes.count > 0)
    }
  }

  func testDevicesList() throws {
    try runThrowingAsyncAndBlock {
      let devices = try await Simctl.listDevices()
      XCTAssert(devices.count > 0)
    }
  }

  func testHasValues() throws {
    try runThrowingAsyncAndBlock {
      let result = try await Simctl.list()
      XCTAssert(result.devicetypes.count > 0)
      XCTAssert(result.runtimes.count > 0)
      XCTAssert(result.devices.count > 0)
    }
  }

  func testSearchTerm() throws {
    try runThrowingAsyncAndBlock {
      let searchTerm = "iPad"

      for (_, devices) in try await Simctl.listDevices(searchTerm: .text(searchTerm)) {
        for device in devices {
          XCTAssert(device.name.contains(searchTerm))
          XCTAssertFalse(device.name.contains("iPhone"))
        }
      }
    }
  }

  /* timeouts on my machine */
//  func testPbCopyPaster() throws {
//    try runThrowingAsyncAndBlock {
//      let expected = "swift-simctl"
//      guard let bootedDevice = try await Simctl.bootedDevice() else {
//        XCTFail(); return
//      }
//      print(bootedDevice.id)
//      try await Simctl.pbcopy(expected, to: .device(bootedDevice))
//      let devicePb = try await Simctl.pbpaste(from: .device(bootedDevice))
//      XCTAssertEqual(expected, devicePb)
//    }
//  }
}

