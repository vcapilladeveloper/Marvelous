// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "FeatureArticleList",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "FeatureArticleList", targets: ["FeatureArticleList"])
    ],
    dependencies: [
        .package(path: "../CoreModels"),
        .package(path: "../CoreNetworking"),
        .package(path: "../DesignSystem"),
        .package(path: "../Config"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "1.21.1")
    ],
    targets: [
        .target(
            name: "FeatureArticleList",
            dependencies: [
                "CoreModels",
                "CoreNetworking",
                "DesignSystem",
                "Config",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .testTarget(
            name: "FeatureArticleListTests",
            dependencies: [
                "FeatureArticleList",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        )
    ]
)
