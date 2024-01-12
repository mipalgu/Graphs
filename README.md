# Graphs

**Graphs** is a swift package that implements a rudimenary force-directed graph algorithm for creating
visually appealing graphs.

## Prerequisites

### Swift 5.8 or Higher

To build, download Swift from https://swift.org/download/ -- if you are using macOS, make sure you have the command line tools installed as well). Test that your compiler works using swift --version, which should give you something like
```bash
$ swift --version
swift-driver version: 1.45.2 Apple Swift version 5.8...
Target: x86_64-apple-darwin20.3.0
```
on macOS, or on Linux you should get something like:
```bash
$ swift --version
Swift version 5.8 (swift-5.8-RELEASE)
Target: x86_64-unknown-linux-gnu
```

## Usage

### Embedding this Package

Typically, you need to embed this package into your own project using the [Swift Package Manager](https://swift.org/package-manager/).  After installing the prerequisites, add this package as a dependency to your `Package.swift` file, e.g.:

```swift
// swift-tools-version:5.8

import PackageDescription

let package = Package(name: "MyPackage",
    dependencies: [
        .package(url: "https://github.com/mipalgu/Graphs", from: "1.0.0"),
    ],
    targets: [
        .target(name: "MyPackage",
                dependencies: [
                    .product(name: "Graphs", package: "Graphs")
                ]
        )
    ]
)
```
