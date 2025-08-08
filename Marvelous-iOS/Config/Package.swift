// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Config",
    products: [
        .library(
            name: "Config",
            targets: ["Config"]),
    ],
    targets: [
        .target(
            name: "Config"),
        .testTarget(
            name: "ConfigTests",
            dependencies: ["Config"]
        ),
    ]
)
