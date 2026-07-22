import SwiftUI

/// Shared animation timing and spring configurations.
///
/// All animations across features should use these constants
/// for a consistent motion language.
public enum AnimationConstants {

    /// Standard spring for most UI transitions.
    public static let defaultSpring = Animation.spring(
        response: 0.35,
        dampingFraction: 0.85,
        blendDuration: 0
    )

    /// Snappy spring for quick feedback (button press, toggle).
    public static let snappySpring = Animation.spring(
        response: 0.25,
        dampingFraction: 0.9,
        blendDuration: 0
    )

    /// Bouncy spring for playful elements (notch expand).
    public static let bouncySpring = Animation.spring(
        response: 0.45,
        dampingFraction: 0.7,
        blendDuration: 0
    )

    /// Gentle ease for subtle state changes.
    public static let gentleEase = Animation.easeInOut(duration: 0.3)

    /// Fast fade for appear/disappear.
    public static let fastFade = Animation.easeOut(duration: 0.15)

    /// Standard duration for non-spring animations.
    public static let standardDuration: TimeInterval = 0.3
}
