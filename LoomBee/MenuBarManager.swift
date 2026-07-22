import AppKit
import LoomBeeDesignSystem
import SwiftUI

/// Manages the status bar item and its menu.
///
/// This is the primary user-facing entry point for the app.
/// In later parts, clicking the status item will also toggle
/// the notch overlay panel.
@MainActor
@Observable
final class MenuBarManager {

    private var statusItem: NSStatusItem?

    init() {}

    /// Set up the status bar item with icon and menu.
    func setUp() {
        let statusItem = NSStatusBar.system.statusItem(
            withLength: NSStatusItem.squareLength
        )

        if let button = statusItem.button {
            button.image = NSImage(
                systemSymbolName: "hexagon.fill",
                accessibilityDescription: "LoomBee"
            )
            button.image?.size = NSSize(width: 18, height: 18)
            button.image?.isTemplate = true
        }

        let menu = NSMenu()

        let aboutItem = NSMenuItem(
            title: "About LoomBee",
            action: #selector(showAbout),
            keyEquivalent: ""
        )
        aboutItem.target = self
        menu.addItem(aboutItem)

        menu.addItem(.separator())

        let quitItem = NSMenuItem(
            title: "Quit LoomBee",
            action: #selector(quitApp),
            keyEquivalent: "q"
        )
        quitItem.target = self
        menu.addItem(quitItem)

        statusItem.menu = menu
        self.statusItem = statusItem
    }

    @objc
    private func showAbout() {
        NSApplication.shared.orderFrontStandardAboutPanel(nil)
        NSApplication.shared.activate(ignoringOtherApps: true)
    }

    @objc
    private func quitApp() {
        NSApplication.shared.terminate(nil)
    }
}
