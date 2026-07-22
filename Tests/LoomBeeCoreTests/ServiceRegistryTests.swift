import Testing

@testable import LoomBeeCore

// MARK: - Test Doubles

private final class MockService: ServiceProtocol, @unchecked Sendable {
    let name: String
    init(name: String = "mock") { self.name = name }
}

// MARK: - Tests

@Suite("ServiceRegistry Tests")
struct ServiceRegistryTests {

    @Test("Registering and resolving a service returns the same instance")
    func registerAndResolve() async {
        let registry = ServiceRegistry()
        let service = MockService(name: "test")

        await registry.register(service, for: MockService.self)
        let resolved = await registry.resolve(MockService.self)

        #expect(resolved === service)
        #expect(resolved?.name == "test")
    }

    @Test("Resolving an unregistered service returns nil")
    func resolveUnregistered() async {
        let registry = ServiceRegistry()

        let resolved = await registry.resolve(MockService.self)

        #expect(resolved == nil)
    }

    @Test("isRegistered returns true for registered services")
    func isRegistered() async {
        let registry = ServiceRegistry()
        let service = MockService()

        #expect(await registry.isRegistered(MockService.self) == false)

        await registry.register(service, for: MockService.self)

        #expect(await registry.isRegistered(MockService.self) == true)
    }
}
