import AppKit
import LoomBeeCore

/// The single `NSApplicationDelegate` for LoomBee.
///
/// Reads shared dependencies from `AppEnvironment` (see that file for
/// rationale on the singleton pattern). Handles app lifecycle events
/// that SwiftUI's `@main` doesn't cover.
@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {

    override init() {
        super.init()
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Hide from Dock — LoomBee is a menu bar (accessory) app
        NSApplication.shared.setActivationPolicy(.accessory)

        // Set up the single shared MenuBarManager
        AppEnvironment.menuBarManager.setUp()

        // Publish lifecycle event through the shared EventBus
        Task {
            await AppEnvironment.eventBus.publish(.appDidLaunch)
        }
    }

    func applicationWillTerminate(_ notification: Notification) {
        Task {
            await AppEnvironment.eventBus.publish(.appWillTerminate)
        }
    }
}
