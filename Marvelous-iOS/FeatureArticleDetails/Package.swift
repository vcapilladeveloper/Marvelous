// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "FeatureArticleDetails",
    defaultLocalization: "en",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "FeatureArticleDetails", targets: ["FeatureArticleDetails"])
    ],
    dependencies: [
        .package(path: "../CoreModels"),
        .package(path: "../DesignSystem"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "1.21.1")
    ],
    targets: [
        .target(
            name: "FeatureArticleDetails",
            dependencies: [
                "CoreModels",
                "DesignSystem",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "FeatureArticleDetailsTests",
            dependencies: [
                "FeatureArticleDetails",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        )
    ]
)
