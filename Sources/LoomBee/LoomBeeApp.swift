import LoomBeeCore
import LoomBeeDesignSystem
import SwiftUI

/// The main entry point for LoomBee.
///
/// Sets up the app as a menu-bar-only accessory application.
/// Core services and the MenuBarManager live in `AppEnvironment`
/// so they are accessible to both this struct and the `AppDelegate`.
@main
struct LoomBeeApp: App {

    // MARK: - App Delegate

    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        // Use a Settings scene as a placeholder — the real UI lives in
        // the notch overlay (implemented in Part 2). MenuBar scene is
        // not needed because we create the NSStatusItem manually.
        Settings {
            Text("LoomBee Settings")
                .font(Typography.title)
                .foregroundStyle(LoomBeeTheme.textPrimary)
                .frame(width: 300, height: 200)
                .background(LoomBeeTheme.surfacePrimary)
        }
    }
}
