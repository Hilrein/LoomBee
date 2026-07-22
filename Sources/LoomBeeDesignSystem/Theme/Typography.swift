import SwiftUI

/// Typography styles for the LoomBee design system.
///
/// Uses the system font (SF Pro) with carefully chosen weights
/// and sizes for the notch overlay context (compact, high-density).
public enum Typography {

    /// Large title — used sparingly (e.g., settings header).
    public static let largeTitle = Font.system(size: 20, weight: .bold, design: .rounded)

    /// Section title.
    public static let title = Font.system(size: 15, weight: .semibold, design: .rounded)

    /// Body text.
    public static let body = Font.system(size: 13, weight: .regular)

    /// Secondary/caption text.
    public static let caption = Font.system(size: 11, weight: .regular)

    /// Small labels (e.g., time display, status indicators).
    public static let label = Font.system(size: 10, weight: .medium)

    /// Monospaced for data display.
    public static let mono = Font.system(size: 12, weight: .regular, design: .monospaced)
}
