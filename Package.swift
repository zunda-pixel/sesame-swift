// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "sesame-swift",
  platforms: [
    .iOS(.v13),
    .macOS(.v13),
  ],
  products: [
    .library(
      name: "Sesame",
      targets: [
        "SesameRemote",
        "SesameLocal"
      ]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-http-types.git", from: "1.3.1"),
    .package(url: "https://github.com/zunda-pixel/http-client.git", from: "0.3.0"),
  ],
  targets: [
    .target(
      name: "SesameLocal"
    ),
    .target(
      name: "SesameRemote",
      dependencies: [
        .product(name: "HTTPClient", package: "http-client"),
        .product(name: "HTTPTypes", package: "swift-http-types"),
        .product(name: "HTTPTypesFoundation", package: "swift-http-types"),
      ]
    ),
    .testTarget(
      name: "SesameRemoteTests",
      dependencies: ["SesameRemote"]
    ),
    .testTarget(
      name: "SesameLocalTests",
      dependencies: ["SesameLocal"]
    ),
  ]
)
