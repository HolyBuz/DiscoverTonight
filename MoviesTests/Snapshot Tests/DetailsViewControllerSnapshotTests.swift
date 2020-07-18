import SnapshotTesting
import XCTest
@testable import Movies

class DetailsViewControllerSnapshotTests: XCTestCase {
    var recordMode = false {
        didSet {
            record = recordMode
        }
    }

    
    func testDetailsViewController_LoadedState() {
        verifyViewOnAllDevices {
            let viewController = DetailsViewController()
            viewController.viewWillAppear(false)
            viewController.update(with: DiscoverViewModel.testData())
            return viewController
        }
    }
}
