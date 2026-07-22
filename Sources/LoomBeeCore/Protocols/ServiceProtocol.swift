/// Base protocol for all services registered in the `ServiceRegistry`.
///
/// Services are the primary mechanism for cross-feature communication.
/// Features declare conformance to specific service protocols (which extend
/// `ServiceProtocol`), and the App layer registers concrete implementations
/// at startup.
public protocol ServiceProtocol: AnyObject, Sendable {

    /// A unique identifier for this service type.
    /// Defaults to the type name.
    static var serviceIdentifier: String { get }
}

extension ServiceProtocol {

    public static var serviceIdentifier: String {
        String(describing: Self.self)
    }
}
