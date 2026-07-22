import LoomBeeCore
import LoomBeeDesignSystem
import SwiftUI

/// HUD replacement for volume, brightness, and keyboard backlight.
///
/// Replaces the system OSD with a notch-integrated display.
/// Implementation in Part 3+.
public struct HUDFeature {

    public init() {}

    @MainActor
    public func makeView() -> some View {
        Text("HUD — Coming Soon")
            .font(Typography.caption)
            .foregroundStyle(LoomBeeTheme.textSecondary)
    }
}
