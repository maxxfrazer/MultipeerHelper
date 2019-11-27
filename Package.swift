// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "MultipeerHelper",
  platforms: [.iOS("13.0")],
  products: [
    .library(name: "MultipeerHelper", targets: ["MultipeerHelper"])
  ],
  targets: [
    .target(name: "MultipeerHelper")
  ],
  swiftLanguageVersions: [.v5]
)
