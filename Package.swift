// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "ReactionButton",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "ReactionButton",
            targets: ["ReactionButton"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ReactionButton",
            dependencies: []),
        .testTarget(
            name: "ReactionButtonTests",
            dependencies: ["ReactionButton"]),
    ]
)
