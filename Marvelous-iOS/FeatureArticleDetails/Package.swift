// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "FeatureArticleDetails",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "FeatureArticleDetails", targets: ["FeatureArticleDetails"])
    ],
    dependencies: [
        .package(path: "../CoreModels"),
        .package(path: "../DesignSystem"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "1.10.0")
    ],
    targets: [
        .target(
            name: "FeatureArticleDetails",
            dependencies: [
                "CoreModels",
                "DesignSystem",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
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
