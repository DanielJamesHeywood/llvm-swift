// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "llvm-swift",
    platforms: [.macOS("27.0.0")],
    products: [.library(name: "LLVM", targets: ["LLVM"])],
    targets: [
        .target(name: "LLVM", dependencies: ["LLVMC"]),
        .systemLibrary(name: "LLVMC", pkgConfig: "llvm", providers: [.brew(["llvm"])])
    ]
)
