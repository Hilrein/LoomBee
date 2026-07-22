import Foundation

/// A thread-safe, actor-based event bus for cross-feature communication.
///
/// Features publish events and subscribe to filtered streams by category.
/// The `EventBus` uses `AsyncStream` continuations internally to distribute
/// events to all active subscribers.
///
/// ## Usage
/// ```swift
/// let bus = EventBus()
///
/// // Subscribe
/// Task {
///     for await event in await bus.stream(for: .system) {
///         print("Received: \(event)")
///     }
/// }
///
/// // Publish
/// await bus.publish(.appDidLaunch)
/// ```
public actor EventBus {

    /// A subscriber entry: the category filter and its continuation.
    private struct Subscriber {
        let category: AppEvent.Category?
        let continuation: AsyncStream<AppEvent>.Continuation
    }

    private var subscribers: [UUID: Subscriber] = [:]

    public init() {}

    /// Publish an event to all subscribers whose category filter matches.
    public func publish(_ event: AppEvent) {
        for (_, subscriber) in subscribers {
            if subscriber.category == nil || subscriber.category == event.category {
                subscriber.continuation.yield(event)
            }
        }
    }

    /// Subscribe to events matching a specific category.
    ///
    /// - Parameter category: The event category to filter on.
    ///   Pass `nil` to receive all events.
    /// - Returns: An `AsyncStream` of matching events.
    public func stream(for category: AppEvent.Category? = nil) -> AsyncStream<AppEvent> {
        let id = UUID()

        return AsyncStream { continuation in
            let subscriber = Subscriber(category: category, continuation: continuation)
            self.subscribers[id] = subscriber

            continuation.onTermination = { @Sendable _ in
                Task { await self.removeSubscriber(id: id) }
            }
        }
    }

    /// Remove a subscriber by its ID.
    private func removeSubscriber(id: UUID) {
        subscribers.removeValue(forKey: id)
    }
}
