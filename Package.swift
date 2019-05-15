// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Cider",
    products: [
        .library(
            name: "Cider",
            targets: ["Cider"]),
    ],
    targets:[
        .target(
            name: "Cider",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "CiderTests",
            dependencies: ["Cider"]),
    ]
)
