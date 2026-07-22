# Contributing to LoomBee

Thank you for your interest in contributing! This guide covers the development workflow.

## Prerequisites

- macOS 14 (Sonoma) or later
- Xcode 16 or later
- Homebrew

Install development tools:
```bash
brew install swiftlint swiftformat
```

## Development Workflow

### 1. Set up the project

```bash
git clone https://github.com/your-org/loombee.git
cd loombee
open LoomBee.xcodeproj
```

### 2. Install the pre-commit hook (recommended)

```bash
cp scripts/pre-commit .git/hooks/pre-commit
```

This will auto-format and lint your Swift files before each commit.

### 3. Create a branch

```
feature/short-description   — new features
fix/short-description       — bug fixes
chore/short-description     — tooling, CI, docs
refactor/short-description  — code restructuring
```

Example: `feature/media-controls`, `fix/notch-geometry-offset`

### 4. Make your changes

- Follow the module architecture in [ARCHITECTURE.md](ARCHITECTURE.md)
- Features go in `Sources/Features/<FeatureName>/`
- Core logic (no UI) goes in `Sources/LoomBeeCore/`
- Shared UI components go in `Sources/LoomBeeDesignSystem/`

### 5. Run checks locally

```bash
# Format
swiftformat .

# Lint
swiftlint lint

# Build
swift build

# Test
swift test
```

### 6. Commit

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat(media): add play/pause button
fix(hud): correct brightness slider range
chore(ci): update Xcode version in workflow
docs: update architecture diagram
test(core): add EventBus edge case tests
refactor(design-system): extract color tokens
```

Format: `type(scope): description`

- `type`: feat, fix, chore, docs, test, refactor, style, perf
- `scope`: module name (core, design-system, media, hud, file-shelf, calendar, settings, ci)
- `description`: imperative mood, lowercase, no period

### 7. Open a PR

- Target the `main` branch
- Fill in the PR template
- CI must pass (build + test + lint + format check)

## Code Style

- **SwiftFormat** handles all formatting (indentation, spacing, braces)
- **SwiftLint** handles code quality rules (force unwrapping, naming, complexity)
- Don't fight the tools — if a rule is wrong for a specific case, use `// swiftlint:disable:next` with a comment explaining why

## Module Rules

1. **Core** must not import SwiftUI or AppKit
2. **Features** must not import other features
3. **DesignSystem** must not import feature modules
4. **App** is the only module that imports everything

See [ARCHITECTURE.md](ARCHITECTURE.md) for the full dependency diagram.
