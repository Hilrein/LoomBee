import Testing

@testable import LoomBeeCore

@Suite("EventBus Tests")
struct EventBusTests {

    @Test("Publishing an event delivers it to matching subscribers")
    func publishDeliversToMatchingSubscribers() async {
        let bus = EventBus()

        let stream = await bus.stream(for: .system)

        await bus.publish(.appDidLaunch)

        var received: AppEvent?
        for await event in stream {
            received = event
            break // Take only the first event
        }

        #expect(received == .appDidLaunch)
    }

    @Test("Subscriber with nil category receives all events")
    func nilCategoryReceivesAllEvents() async {
        let bus = EventBus()

        let stream = await bus.stream(for: nil)

        await bus.publish(.appDidLaunch)

        var received: AppEvent?
        for await event in stream {
            received = event
            break
        }

        #expect(received == .appDidLaunch)
    }

    @Test("Subscriber does not receive events from wrong category")
    func wrongCategoryFilteredOut() async {
        let bus = EventBus()

        let stream = await bus.stream(for: .media)

        // Publish a system event — the .media subscriber should NOT get it
        await bus.publish(.appDidLaunch)

        // Give a brief window for delivery, then check no events arrived
        let task = Task {
            var count = 0
            for await _ in stream {
                count += 1
                if count > 0 { break }
            }
            return count
        }

        // Cancel after a short delay — if no event was received, this is correct
        try? await Task.sleep(for: .milliseconds(50))
        task.cancel()

        let count = await task.value
        #expect(count == 0)
    }
}
