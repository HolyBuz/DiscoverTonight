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
        let exp = expectation(description: "Get Screenshot")
        
        let viewController = DetailsViewController()
        viewController.update(with: DiscoverViewModel.testData())
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 , execute: {
            self.verifyViewOnAllDevices {
                return viewController
            }
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 3)
    }
}
