# 🐝 LoomBee

An open-source macOS app that transforms your MacBook's display notch into an interactive control center.

> **Status:** Part 1 — Project scaffolding complete. No features implemented yet.

## Features (Planned)

- 🎵 **Media Controls** — Play/pause, skip, and track info in the notch
- 🔊 **HUD Replacement** — Volume and brightness indicators integrated into the notch
- 📁 **File Shelf** — Drag-and-drop temporary file staging
- 📅 **Calendar Widget** — Upcoming events at a glance
- ⚙️ **Settings** — Full customization of appearance and behavior

## Requirements

- **macOS 14 (Sonoma)** or later
- **Xcode 16** or later
- **Swift 6**
- A MacBook with a display notch (MacBook Pro 14"/16" 2021+, MacBook Air 2022+)

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/your-org/loombee.git
cd loombee
```

### 2. Open the Xcode project

```bash
open LoomBee.xcodeproj
```

### 3. Build and run

**Option A — Xcode:**
```bash
open LoomBee.xcodeproj
# Press ⌘R to build and run
```

**Option B — Command line:**
```bash
swift build
swift run LoomBee
```

### 4. Run tests

```bash
swift test
```

## Architecture

See [ARCHITECTURE.md](ARCHITECTURE.md) for the full architecture documentation, including module structure, state management, and cross-feature communication patterns.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for branch naming, commit conventions, and how to run lint/tests locally.

## License

[MIT](LICENSE) — Copyright © 2026 LoomBee Contributors
