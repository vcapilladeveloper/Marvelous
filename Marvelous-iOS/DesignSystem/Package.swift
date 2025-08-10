// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "DesignSystem", targets: ["DesignSystem"])
    ],
    dependencies: [
        // Lottie (Airbnb)
        .package(url: "https://github.com/airbnb/lottie-ios.git", from: "4.4.0"),
        // ViewInspector (tests only)
        .package(url: "https://github.com/nalexn/ViewInspector.git", from: "0.9.10")
    ],
    targets: [
        .target(
            name: "DesignSystem",
            dependencies: [
                .product(name: "Lottie", package: "lottie-ios")
            ],
            resources: [
                .process("Resources/Animations")
            ]
        ),
        .testTarget(
            name: "DesignSystemTests",
            dependencies: [
                "DesignSystem",
                "ViewInspector"
            ]
        )
    ]
)
