// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "swift-simctl",
  platforms: [
    .macOS(.v12),
  ],
  products: [
    .library(
      name: "Simctl",
      targets: ["Simctl"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/S2Ler/swift-shell.git", .branch("master")),
  ],
  targets: [
    .target(
      name: "Simctl",
      dependencies: [
        .product(name: "Shell", package: "swift-shell"),
      ]
    ),
    .testTarget(
      name: "SimctlTests",
      dependencies: ["Simctl"]
    ),
  ],
  swiftLanguageVersions: [.v5]
)
