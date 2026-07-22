import LoomBeeCore
import LoomBeeDesignSystem
import SwiftUI

/// Media playback controls feature.
///
/// Will display currently playing track info, play/pause/skip controls,
/// and artwork. Implementation in Part 3+.
public struct MediaControlFeature {

    public init() {}

    @MainActor
    public func makeView() -> some View {
        Text("Media Control — Coming Soon")
            .font(Typography.caption)
            .foregroundStyle(LoomBeeTheme.textSecondary)
    }
}
