import LoomBeeCore
import LoomBeeDesignSystem
import SwiftUI

/// App settings and preferences.
///
/// Allows customization of notch behavior, enabled features,
/// appearance, and keybindings. Implementation in Part 5+.
public struct SettingsFeature {

    public init() {}

    @MainActor
    public func makeView() -> some View {
        Text("Settings — Coming Soon")
            .font(Typography.caption)
            .foregroundStyle(LoomBeeTheme.textSecondary)
    }
}
