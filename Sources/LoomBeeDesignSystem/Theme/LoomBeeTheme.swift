import SwiftUI

/// The LoomBee design system color palette.
///
/// All colors are defined here. Feature modules MUST use these
/// rather than defining ad-hoc colors.
public enum LoomBeeTheme {

    // MARK: - Surface Colors

    /// Primary background — near-black with slight warmth.
    public static let surfacePrimary = Color(hue: 0.67, saturation: 0.08, brightness: 0.10)

    /// Secondary/elevated surface.
    public static let surfaceSecondary = Color(hue: 0.67, saturation: 0.06, brightness: 0.15)

    /// Tertiary surface for cards/popovers.
    public static let surfaceTertiary = Color(hue: 0.67, saturation: 0.04, brightness: 0.20)

    // MARK: - Text Colors

    /// Primary text — off-white for readability.
    public static let textPrimary = Color(white: 0.95)

    /// Secondary text — muted.
    public static let textSecondary = Color(white: 0.60)

    /// Tertiary text — subtle labels.
    public static let textTertiary = Color(white: 0.40)

    // MARK: - Accent Colors

    /// Primary accent — a warm amber/gold.
    public static let accentPrimary = Color(hue: 0.10, saturation: 0.85, brightness: 0.95)

    /// Secondary accent — complementary blue.
    public static let accentSecondary = Color(hue: 0.58, saturation: 0.70, brightness: 0.90)

    // MARK: - Semantic Colors

    /// Success state.
    public static let success = Color(hue: 0.35, saturation: 0.70, brightness: 0.80)

    /// Warning state.
    public static let warning = Color(hue: 0.12, saturation: 0.80, brightness: 0.90)

    /// Error/destructive state.
    public static let error = Color(hue: 0.0, saturation: 0.75, brightness: 0.85)

    // MARK: - Spacing

    /// Standard spacing scale (4pt grid).
    public enum Spacing {
        public static let xxs: CGFloat = 2
        public static let xs: CGFloat = 4
        public static let sm: CGFloat = 8
        public static let md: CGFloat = 12
        public static let lg: CGFloat = 16
        public static let xl: CGFloat = 24
        public static let xxl: CGFloat = 32
    }

    // MARK: - Corner Radii

    public enum CornerRadius {
        public static let sm: CGFloat = 6
        public static let md: CGFloat = 10
        public static let lg: CGFloat = 16
        public static let pill: CGFloat = 999
    }
}
