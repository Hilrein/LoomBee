import Foundation

/// A thread-safe, actor-based dependency injection container.
///
/// The App layer registers concrete service implementations at startup.
/// Feature modules resolve services by protocol type at runtime.
///
/// ## Usage
/// ```swift
/// let registry = ServiceRegistry()
///
/// // Register (in App layer)
/// await registry.register(myMediaService, for: MediaProviding.self)
///
/// // Resolve (in Feature module)
/// let media = await registry.resolve(MediaProviding.self)
/// ```
public actor ServiceRegistry {

    private var services: [String: any ServiceProtocol] = [:]

    public init() {}

    /// Register a service implementation for a given protocol type.
    ///
    /// - Parameters:
    ///   - service: The concrete service instance.
    ///   - type: The protocol type to register under.
    public func register<T: ServiceProtocol>(_ service: T, for type: T.Type) {
        let key = String(describing: type)
        services[key] = service
    }

    /// Resolve a service by its protocol type.
    ///
    /// - Parameter type: The protocol type to resolve.
    /// - Returns: The registered service, or `nil` if not found.
    public func resolve<T: ServiceProtocol>(_ type: T.Type) -> T? {
        let key = String(describing: type)
        return services[key] as? T
    }

    /// Check whether a service is registered for a given type.
    public func isRegistered<T: ServiceProtocol>(_ type: T.Type) -> Bool {
        let key = String(describing: type)
        return services[key] != nil
    }
}
