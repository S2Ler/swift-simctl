// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "simctl",
    platforms: [
      .macOS(.v10_15),
  ],
    products: [
        .library(
            name: "simctl",
            targets: ["simctl"]),
    ],
    dependencies: [

    ],
    targets: [
        .target(
            name: "simctl",
            dependencies: []),
    ],
    swiftLanguageVersions: [.v5]
)
