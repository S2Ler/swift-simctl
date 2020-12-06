// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "swift-simctl",
  platforms: [
    .macOS(.v11),
  ],
  products: [
    .library(
      name: "Simctl",
      targets: ["Simctl"]
    ),
  ],
  dependencies: [

  ],
  targets: [
    .target(
      name: "Simctl",
      dependencies: []
    ),
    .testTarget(
      name: "SimctlTests",
      dependencies: ["Simctl"]
    ),
  ],
  swiftLanguageVersions: [.v5]
)
