// swift-tools-version:5.1

/**
 *  CDNetworking
 *  Copyright (c) Corgi Devs 2019
 *  Licensed under the MIT license. See LICENSE file.
 */

import PackageDescription

let package = Package(
    name: "CDNetworking",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "CDNetworking",
            targets: ["CDNetworking"]),
    ],
    dependencies: [
        .package(url: "https://github.com/orta/PackageConfig.git", from: "0.10.0"),
        .package(url: "https://github.com/orta/Komondor.git", from: "1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "CDNetworking",
            dependencies: []),
        .testTarget(
            name: "CDNetworkingTests",
            dependencies: ["CDNetworking"]),
    ]
)

#if canImport(PackageConfig)
    import PackageConfig

    let config = PackageConfig([
        "komondor": [
            "pre-push": "swift test",
            "pre-commit": [
                "swift test",
                "swift run swiftlint autocorrect --path Sources/",
                "git add .",
            ],
        ],
    ])
#endif
