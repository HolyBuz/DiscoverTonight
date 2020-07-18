import XCTest
@testable import Movies

final class MockCoreService: Service {
    var discoverService: DiscoverService
    
    init() {
        discoverService = MockDiscoverService()
    }
}
