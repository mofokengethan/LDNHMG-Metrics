// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LDNHMG-Metrics",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "LDNHMG-Metrics",
            targets: ["LDNHMG-Metrics"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // package(url: /* package url */, from: "1.0.0")
        .package(url: "https://github.com/firebase/firebase-ios-sdk",from: "11.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "LDNHMG-Metrics",
            dependencies: [
                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk")
            ]
        ),
        .testTarget(
            name: "LDNHMG-MetricsTests",
            dependencies: ["LDNHMG-Metrics"]
        ),
    ]
)
