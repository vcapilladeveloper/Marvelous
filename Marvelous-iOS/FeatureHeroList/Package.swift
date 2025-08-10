// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "FeatureHeroList",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "FeatureHeroList", targets: ["FeatureHeroList"])
    ],
    dependencies: [
        .package(path: "../CoreModels"),
        .package(path: "../CoreNetworking"),
        .package(path: "../DesignSystem"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "1.21.1")
    ],
    targets: [
        .target(
            name: "FeatureHeroList",
            dependencies: [
                "CoreModels",
                "CoreNetworking",
                "DesignSystem",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .testTarget(
            name: "FeatureHeroListTests",
            dependencies: [
                "FeatureHeroList",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        )
    ]
)
