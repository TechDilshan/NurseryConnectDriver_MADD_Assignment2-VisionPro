// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "RealityKitContent",
    platforms: [
        .visionOS(.v1),
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "RealityKitContent",
            targets: ["RealityKitContent"]
        ),
    ],
    targets: [
        .target(
            name: "RealityKitContent",
            dependencies: [],
            resources: [
                .process("RealityKitContent.rkassets")
            ]
        ),
    ]
)
