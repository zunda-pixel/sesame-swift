// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "sesame-swift",
  products: [
    .library(
      name: "Sesame",
      targets: ["Sesame"]
    ),
  ],
  targets: [
    .target(
      name: "Sesame"
    ),
    .testTarget(
      name: "SesameTests",
      dependencies: ["Sesame"]
    ),
  ]
)
