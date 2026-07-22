# LoomBee Architecture

## Overview

LoomBee is a macOS menu bar app that transforms the MacBook notch into an interactive control center. The architecture is designed for modularity, testability, and clean separation of concerns.

## Module Dependency Diagram

```
┌─────────────────────────────────────────────────────┐
│                    LoomBee (App)                     │
│  App lifecycle, dependency wiring, menu bar item    │
├─────────┬───────┬────────┬───────────┬──────────────┤
│ Feature │Feature│Feature │  Feature  │   Feature    │
│ Media   │  HUD  │ File   │ Calendar  │  Settings    │
│ Control │       │ Shelf  │           │              │
├─────────┴───────┴────────┴───────────┴──────────────┤
│              LoomBeeDesignSystem                     │
│  Theme, typography, animation, shared components    │
├─────────────────────────────────────────────────────┤
│                  LoomBeeCore                         │
│  EventBus, ServiceRegistry, models, protocols       │
└─────────────────────────────────────────────────────┘
```

### Dependency Rules

1. **Core** has zero dependencies. No SwiftUI imports. CoreGraphics is allowed for display geometry types.
2. **DesignSystem** depends on Core only.
3. **Features** depend on Core + DesignSystem. Never on each other.
4. **App** depends on everything. It's the composition root.

No circular dependencies exist by construction.

## Layers

### Core (`LoomBeeCore`)

Pure logic layer. No UI framework imports (`SwiftUI`, `AppKit`) allowed. `CoreGraphics` is permitted for display-related types.

**Contains:**
- `EventBus` — Actor-based pub/sub for cross-feature communication using `AsyncStream`
- `ServiceRegistry` — Actor-based DI container for service resolution
- `ServiceProtocol` — Base protocol for all registered services
- `AppEvent` — Typed event enum with category filtering
- Shared models (e.g., `DisplayInfo`)

**Public API:** All protocols, the `EventBus` actor, the `ServiceRegistry` actor, model types.
**Internal:** Implementation details of event routing and service storage.
**Testing:** Fully testable in isolation — no UI dependencies, pure async/actor tests.

### DesignSystem (`LoomBeeDesignSystem`)

Shared visual language for the entire app.

**Contains:**
- `LoomBeeTheme` — Color palette, spacing scale (4pt grid), corner radii
- `Typography` — Font style definitions using SF Pro
- `AnimationConstants` — Spring configs and timing values
- Reusable SwiftUI components (e.g., `GlassBackground` modifier)

**Public API:** All theme constants, typography styles, animation values, view modifiers.
**Internal:** Component implementation details.
**Testing:** Token validation tests (spacing progression, radius ordering).

### Features (`Features/*`)

Each feature is an independent SPM module. Features declare what services they need via Core protocols and what UI they provide.

**Dependency rule:** Features depend on `LoomBeeCore` + `LoomBeeDesignSystem`, never on each other.

**Cross-feature communication:** Features communicate exclusively through Core's `EventBus`:
1. Feature A publishes an `AppEvent` to the `EventBus`
2. Feature B subscribes to an `AsyncStream` filtered by event category
3. No direct imports or knowledge of other features

**Public API:** A feature entry point (e.g., `MediaControlFeature`) with a `makeView()` method.
**Internal:** ViewModels, sub-views, feature-specific logic.
**Testing:** Each feature is testable in isolation by mocking Core protocols.

### App (`LoomBee`)

The composition root and executable target.

**Responsibilities:**
- `@main` app entry point with SwiftUI `App` protocol
- `NSApplicationDelegate` for AppKit lifecycle (dock hiding, etc.)
- `AppEnvironment` — static singleton container for shared dependencies (`EventBus`, `ServiceRegistry`, `MenuBarManager`)
- `MenuBarManager` for the status bar item
- Composes feature views into the notch overlay panel (future parts)

**Why `AppEnvironment`?** SwiftUI's `@NSApplicationDelegateAdaptor` requires a no-arg initializer, making constructor injection into the delegate impossible. `AppEnvironment` is a `@MainActor enum` with `static let` properties, guaranteeing exactly one instance of each dependency for the app's entire lifetime. Both `LoomBeeApp` and `AppDelegate` read from it.

## Presentation Pattern: MVVM

- **Model:** Core types (`AppEvent`, `DisplayInfo`, service protocols)
- **ViewModel:** `@Observable @MainActor` classes in each feature module
  - Depend on Core services via protocol injection
  - Own the feature's mutable state
  - Expose read-only properties to views
  - Are independently testable
- **View:** Thin SwiftUI views that bind to ViewModel properties

## State Management

- **`@Observable` (Observation framework):** Used for all view state. Requires macOS 14+.
  - Provides per-property change tracking (more efficient than `ObservableObject`)
  - Views use plain properties or `@State` for ownership
  - `@Bindable` for two-way bindings
  - `@Environment` for DI from parent views

- **`@MainActor` isolation:** All ViewModels and UI-facing state are `@MainActor`-isolated.
  - Guarantees main-thread access for UI updates
  - Async work suspends and resumes on the main actor automatically

- **Actors for shared state:** `EventBus` and `ServiceRegistry` are actors.
  - Provides compiler-verified thread safety
  - Cross-actor calls are `await`-based

- **`Sendable` conformance:** All types that cross actor/module boundaries conform to `Sendable`.
  - Value types (structs, enums) are automatically `Sendable` if all properties are
  - `@unchecked Sendable` used only when manual thread safety is documented

## Cross-Feature Communication: Protocol-Based Event Bus

Features never import or depend on each other. Instead:

```
Feature A ──publish──▶ EventBus ──stream──▶ Feature B
               (actor)
```

1. **Publishing:** A feature calls `await eventBus.publish(.someEvent)`
2. **Subscribing:** A feature creates a `Task` that iterates over `await eventBus.stream(for: .category)`
3. **Service injection:** For direct service calls (not events), features resolve services from the `ServiceRegistry` by protocol type

This keeps features decoupled, testable, and independently deployable.

## Project Generation: XcodeGen

**Why XcodeGen over Tuist:**
- Simpler setup (YAML config vs Swift DSL) — lower barrier for contributors
- Right-sized for 5-10 SPM modules — Tuist's caching/scaffolding is overkill
- SPM `Package.swift` remains the true source of truth for module structure
- No external service dependencies (Tuist Cloud)
- Transparent CI: `xcodegen generate && xcodebuild`

**Usage:**
```bash
# Install
brew install xcodegen

# Generate .xcodeproj (not committed to git)
xcodegen generate

# Open in Xcode
open LoomBee.xcodeproj
```

The `project.yml` file is the only source of truth. The generated `.xcodeproj` is in `.gitignore`.

## Concurrency Model

Swift 6 strict concurrency is enabled project-wide:

- `swift-tools-version: 6.0` in Package.swift
- `SWIFT_STRICT_CONCURRENCY: complete` in build settings
- All warnings are treated as errors in CI

Key patterns:
- ViewModels: `@MainActor @Observable class`
- Shared state: `actor` types
- Cross-boundary types: `Sendable` structs/enums
- AppKit interop: Coordinators marked `@MainActor`, no `NSView` captures across isolation boundaries
