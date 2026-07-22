import CoreGraphics
import Foundation

/// Information about a connected display.
///
/// This is a placeholder model for Part 1. In later parts, this will be
/// expanded with notch geometry, safe area insets, and display characteristics.
public struct DisplayInfo: Sendable, Equatable, Identifiable {

    public let id: UUID
    public let displayID: CGDirectDisplayID
    public let frame: CGRect
    public let isBuiltIn: Bool

    public init(
        displayID: CGDirectDisplayID,
        frame: CGRect,
        isBuiltIn: Bool
    ) {
        self.id = UUID()
        self.displayID = displayID
        self.frame = frame
        self.isBuiltIn = isBuiltIn
    }

    public static func == (lhs: DisplayInfo, rhs: DisplayInfo) -> Bool {
        lhs.displayID == rhs.displayID
            && lhs.frame == rhs.frame
            && lhs.isBuiltIn == rhs.isBuiltIn
    }
}
