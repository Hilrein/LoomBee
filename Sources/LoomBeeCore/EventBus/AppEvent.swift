import Foundation

/// Typed events that flow through the `EventBus`.
///
/// Each feature publishes and subscribes to events relevant to its domain.
/// Events are value types (`Sendable`) so they can safely cross actor boundaries.
///
/// - Note: This enum will grow as features are implemented in later parts.
///   For Part 1, only a placeholder `.system` case exists.
public enum AppEvent: Sendable, Equatable {

    /// Categories for filtering event streams.
    public enum Category: Sendable {
        case system
        case media
        case hud
        case fileShelf
        case calendar
        case settings
    }

    // MARK: - System Events (placeholder for Part 1)

    /// The app finished launching.
    case appDidLaunch

    /// The app will terminate.
    case appWillTerminate

    /// The category this event belongs to.
    public var category: Category {
        switch self {
        case .appDidLaunch, .appWillTerminate:
            return .system
        }
    }
}
