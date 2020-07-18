import XCTest
@testable import Movies

class DiscoverServiceTests: XCTestCase {
    
    var discoverService: MockDiscoverService!
    
    override func setUp() {
        super.setUp()
        
        discoverService = MockDiscoverService()
    }
    
    override func tearDown() {
        discoverService.movieListResponse = nil
        discoverService.seriesListResponse = nil
    }

    
    func testGetMovies() {
        let movieList: MovieList = .fromJSON(bundle: Bundle(for: type(of: self)), filename: "MovieListResponse")!
        discoverService.movieListResponse = Result.success(movieList)
        
        let exp = expectation(description: "Get Movies")
        
        discoverService.getMovies(page: 1, completion: { response in
            switch response {
            case .success(let fetchedMovieList):
                XCTAssertEqual(fetchedMovieList.results.count, movieList.results.count)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testGetMoviesFailure() {
        discoverService.movieListResponse = Result.failure(NSError(domain: "Error", code: 400, userInfo: nil))
        
        let exp = expectation(description: "Get Movies")
        
        discoverService.getMovies(page: 1, completion: { response in
            switch response {
            case .success:
                XCTFail("Movies fetched")
            case .failure:
                exp.fulfill()
            }
        })
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testGetSeries() {
        let seriesList: SeriesList = .fromJSON(bundle: Bundle(for: type(of: self)), filename: "SeriesListResponse")!
        discoverService.seriesListResponse = Result.success(seriesList)
        
        let exp = expectation(description: "Get Series")
        
        discoverService.getSeries(page: 1, completion: { response in
            switch response {
            case .success(let fetchedSeriesList):
                XCTAssertEqual(fetchedSeriesList.results.count, seriesList.results.count)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testGetSeriesFailure() {
        discoverService.seriesListResponse = Result.failure(NSError(domain: "Error", code: 400, userInfo: nil))
        
        let exp = expectation(description: "Get Series")
        
        discoverService.getSeries(page: 1, completion: { response in
            switch response {
            case .success:
                XCTFail("Movies fetched")
            case .failure:
                exp.fulfill()
            }
        })

        waitForExpectations(timeout: 0.1)
    }
}

