// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "Jotai",
    platforms: [
        .iOS(.v14) // Change the version as needed
    ],
    products: [
        .library(
            name: "Jotai",
            targets: ["Jotai"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Jotai",
            path: "Sources/Jotai"
        )
    ]
)
