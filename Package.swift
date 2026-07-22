// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "LoomBee",
    platforms: [
        .macOS(.v14),
    ],
    products: [
        .executable(name: "LoomBee", targets: ["LoomBee"]),
        .library(name: "LoomBeeCore", targets: ["LoomBeeCore"]),
        .library(name: "LoomBeeDesignSystem", targets: ["LoomBeeDesignSystem"]),
    ],
    dependencies: [],
    targets: [
        // MARK: - Core
        // Pure logic, no UI. Shared models, protocols, event bus, DI.
        .target(
            name: "LoomBeeCore",
            dependencies: [],
            path: "Sources/LoomBeeCore"
        ),
        .testTarget(
            name: "LoomBeeCoreTests",
            dependencies: ["LoomBeeCore"],
            path: "Tests/LoomBeeCoreTests"
        ),

        // MARK: - Design System
        // Shared SwiftUI components, colors, typography, animation constants.
        .target(
            name: "LoomBeeDesignSystem",
            dependencies: ["LoomBeeCore"],
            path: "Sources/LoomBeeDesignSystem"
        ),
        .testTarget(
            name: "LoomBeeDesignSystemTests",
            dependencies: ["LoomBeeDesignSystem"],
            path: "Tests/LoomBeeDesignSystemTests"
        ),

        // MARK: - Features
        // Each feature is its own module. Depends on Core + DesignSystem only.
        .target(
            name: "FeatureMediaControl",
            dependencies: ["LoomBeeCore", "LoomBeeDesignSystem"],
            path: "Sources/Features/MediaControl"
        ),
        .target(
            name: "FeatureHUD",
            dependencies: ["LoomBeeCore", "LoomBeeDesignSystem"],
            path: "Sources/Features/HUD"
        ),
        .target(
            name: "FeatureFileShelf",
            dependencies: ["LoomBeeCore", "LoomBeeDesignSystem"],
            path: "Sources/Features/FileShelf"
        ),
        .target(
            name: "FeatureCalendar",
            dependencies: ["LoomBeeCore", "LoomBeeDesignSystem"],
            path: "Sources/Features/Calendar"
        ),
        .target(
            name: "FeatureSettings",
            dependencies: ["LoomBeeCore", "LoomBeeDesignSystem"],
            path: "Sources/Features/Settings"
        ),

        // MARK: - App
        // The executable target. Composes everything, handles lifecycle.
        .executableTarget(
            name: "LoomBee",
            dependencies: [
                "LoomBeeCore",
                "LoomBeeDesignSystem",
                "FeatureMediaControl",
                "FeatureHUD",
                "FeatureFileShelf",
                "FeatureCalendar",
                "FeatureSettings",
            ],
            path: "Sources/LoomBee"
        ),
    ]
)
