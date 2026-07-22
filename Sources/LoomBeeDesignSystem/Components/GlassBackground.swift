import SwiftUI

/// A glassmorphism background modifier for LoomBee panels.
///
/// Applies a translucent material effect with a subtle border,
/// consistent with macOS vibrancy patterns.
///
/// ## Usage
/// ```swift
/// SomeView()
///     .modifier(GlassBackground())
/// ```
public struct GlassBackground: ViewModifier {

    private let cornerRadius: CGFloat
    private let material: Material

    public init(
        cornerRadius: CGFloat = LoomBeeTheme.CornerRadius.lg,
        material: Material = .ultraThinMaterial
    ) {
        self.cornerRadius = cornerRadius
        self.material = material
    }

    public func body(content: Content) -> some View {
        content
            .background(material, in: RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
            )
    }
}

extension View {

    /// Apply the LoomBee glass background effect.
    public func glassBackground(
        cornerRadius: CGFloat = LoomBeeTheme.CornerRadius.lg,
        material: Material = .ultraThinMaterial
    ) -> some View {
        modifier(GlassBackground(cornerRadius: cornerRadius, material: material))
    }
}
