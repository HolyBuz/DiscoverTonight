import SnapshotTesting
import XCTest
@testable import Movies

class DiscoverViewControllerSnapshotTests: XCTestCase {
    var facade = MockDiscoverFacade()
    
    var recordMode = false {
        didSet {
            record = recordMode
        }
    }
    
    override func tearDown() {
        facade.shouldReturnError = false
    }
    
    func testProductListViewController_LoadedState() {
        verifyViewOnAllDevices {
            let viewController = DiscoverViewController(facade: self.facade, coordinator: DiscoverCoordinator())
            viewController.viewWillAppear(false)
            return viewController
        }
    }
    
    func testProductListViewController_FailureState() {
        verifyViewOnAllDevices {
            self.facade.shouldReturnError = true
            let viewController = DiscoverViewController(facade: self.facade, coordinator: DiscoverCoordinator())
            viewController.viewWillAppear(false)
            return viewController
        }
    }
}
