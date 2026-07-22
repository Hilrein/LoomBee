import LoomBeeCore

/// Shared app-level dependency container.
///
/// `@NSApplicationDelegateAdaptor` requires a no-arg initializer, which makes
/// constructor injection into the delegate impossible. Instead, we use this
/// static container as the single source of truth for app-wide singletons.
/// Both `LoomBeeApp` and `AppDelegate` read from here — guaranteeing exactly
/// one `EventBus`, one `ServiceRegistry`, and one `MenuBarManager` for the
/// entire app lifetime.
@MainActor
enum AppEnvironment {
    static let eventBus = EventBus()
    static let serviceRegistry = ServiceRegistry()
    static let menuBarManager = MenuBarManager()
}
