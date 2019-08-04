// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "sw-lint",
    platforms: [.macOS(.v10_15)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .executable(
            name: "swlint",
            targets: ["SWLintCLI"]),
        .library(
            name: "SWLintKit",
            targets: ["SWLintKit"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        // .package(url: "https://github.com/apple/swift-syntax.git", .revision("xcode11-beta1"))
        .package(path: "../_swift/swift-syntax"),
        .package(path: "../swift-syntax-util")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SWLintCLI",
            dependencies: ["SWLintKit"]),
        .target(
            name: "SWLintKit",
            dependencies: ["SwiftSyntax", "SwiftSyntaxUtil"]),
        .testTarget(
            name: "SWLintKitTests",
            dependencies: ["SWLintKit", "SwiftSyntax"])
    ],
    swiftLanguageVersions: [.v5]
)
