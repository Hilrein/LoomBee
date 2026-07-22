import LoomBeeCore
import LoomBeeDesignSystem
import SwiftUI

/// Calendar widget showing upcoming events.
///
/// Integrates with EventKit for calendar data.
/// Implementation in Part 4+.
public struct CalendarFeature {

    public init() {}

    @MainActor
    public func makeView() -> some View {
        Text("Calendar — Coming Soon")
            .font(Typography.caption)
            .foregroundStyle(LoomBeeTheme.textSecondary)
    }
}
