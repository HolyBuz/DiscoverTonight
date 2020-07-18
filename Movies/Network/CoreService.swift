import Foundation

protocol Service {
    var discoverService: DiscoverService { get }
}

final class CoreService: Service {
    private let backend = Backend()
    var discoverService: DiscoverService
    
    init() {
        self.discoverService = DiscoverServiceImpl(backend: backend)
    }
}
