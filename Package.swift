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
    .package(url: "https://github.com/S2Ler/swift-shell.git", .branch("master")),
  ],
  targets: [
    .target(
      name: "Simctl",
      dependencies: [
        .product(name: "Shell", package: "swift-shell"),
      ],
      swiftSettings: [.unsafeFlags([
        "-Xfrontend", "-enable-experimental-concurrency",
        "-Xfrontend", "-disable-availability-checking",
      ])]
    ),
    .testTarget(
      name: "SimctlTests",
      dependencies: ["Simctl"],
      swiftSettings: [.unsafeFlags([
        "-Xfrontend", "-enable-experimental-concurrency",
        "-Xfrontend", "-disable-availability-checking",
      ])]
    ),
  ],
  swiftLanguageVersions: [.v5]
)
