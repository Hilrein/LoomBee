import LoomBeeCore
import LoomBeeDesignSystem
import SwiftUI

/// File shelf for drag-and-drop temporary file staging.
///
/// Users can drop files onto the notch area for quick access.
/// Implementation in Part 4+.
public struct FileShelfFeature {

    public init() {}

    @MainActor
    public func makeView() -> some View {
        Text("File Shelf — Coming Soon")
            .font(Typography.caption)
            .foregroundStyle(LoomBeeTheme.textSecondary)
    }
}
