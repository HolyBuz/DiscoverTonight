import XCTest
@testable import Movies

class DiscoverFacadeTests: XCTestCase {
    
    var discoverFacade: MockDiscoverFacade!
    
    override func setUp() {
        super.setUp()
        discoverFacade = MockDiscoverFacade()
    }
    
    func testGetMovies() {
        let movieList: MovieList = .fromJSON(bundle: Bundle(for: type(of: self)), filename: "MovieListResponse")!
        discoverFacade.mockDiscoverService.movieListResponse = Result.success(movieList)
        
        let exp = expectation(description: "Get Movies")
        
        discoverFacade.getMovies(completion: { result in
            switch result {
            case .success(let discoverViewModels):
                XCTAssertEqual(discoverViewModels.count, movieList.results.count)
                XCTAssertEqual(discoverViewModels.first!.title, movieList.results.first!.title)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 1)
    }
    
    func testGetSeries() {
        let seriesList: SeriesList = .fromJSON(bundle: Bundle(for: type(of: self)), filename: "SeriesListResponse")!
        discoverFacade.mockDiscoverService.seriesListResponse = Result.success(seriesList)
        
        let exp = expectation(description: "Get Series")
        
        discoverFacade.getSeries(completion: { result in
            switch result {
            case .success(let discoverViewModels):
                XCTAssertEqual(discoverViewModels.count, seriesList.results.count)
                XCTAssertEqual(discoverViewModels.first!.title, seriesList.results.first!.name)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 2)
    }
}

