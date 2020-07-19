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
    
    func testDiscoverViewController_LoadedState() {
        let exp = expectation(description: "Get Screenshot")

        let movieList: MovieList = .fromJSON(bundle: Bundle(for: type(of: self)), filename: "MovieListResponse")!
        facade.mockDiscoverService.movieListResponse = Result.success(movieList)
        
        let seriesList: SeriesList = .fromJSON(bundle: Bundle(for: type(of: self)), filename: "SeriesListResponse")!
        facade.mockDiscoverService.seriesListResponse = Result.success(seriesList)
        
        let viewController = DiscoverViewController(facade: facade, coordinator: DiscoverCoordinator())
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 , execute: {
            self.verifyViewOnAllDevices {
                return viewController
            }
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 3)
    }
    
    func testDiscoverViewController_FailureState() {
        let exp = expectation(description: "Get Screenshot")
        facade.shouldReturnError = true
        
        let viewController = DiscoverViewController(facade: facade, coordinator: DiscoverCoordinator())
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 , execute: {
            self.verifyViewOnAllDevices {
                return viewController
            }
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 3)
    }
}
