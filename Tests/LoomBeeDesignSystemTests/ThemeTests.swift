import SwiftUI
import Testing

@testable import LoomBeeDesignSystem

@Suite("DesignSystem Theme Tests")
struct ThemeTests {

    @Test("Spacing values follow 4pt grid progression")
    func spacingProgression() {
        #expect(LoomBeeTheme.Spacing.xxs < LoomBeeTheme.Spacing.xs)
        #expect(LoomBeeTheme.Spacing.xs < LoomBeeTheme.Spacing.sm)
        #expect(LoomBeeTheme.Spacing.sm < LoomBeeTheme.Spacing.md)
        #expect(LoomBeeTheme.Spacing.md < LoomBeeTheme.Spacing.lg)
        #expect(LoomBeeTheme.Spacing.lg < LoomBeeTheme.Spacing.xl)
        #expect(LoomBeeTheme.Spacing.xl < LoomBeeTheme.Spacing.xxl)
    }

    @Test("Corner radius values are ordered")
    func cornerRadiusProgression() {
        #expect(LoomBeeTheme.CornerRadius.sm < LoomBeeTheme.CornerRadius.md)
        #expect(LoomBeeTheme.CornerRadius.md < LoomBeeTheme.CornerRadius.lg)
        #expect(LoomBeeTheme.CornerRadius.lg < LoomBeeTheme.CornerRadius.pill)
    }

    @Test("Animation standard duration is positive")
    func animationDuration() {
        #expect(AnimationConstants.standardDuration > 0)
    }
}
