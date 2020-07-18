import XCTest
@testable import Movies

class DiscoverViewModelTests: XCTestCase {
    
    var discoverViewModel: DiscoverViewModel!
    
    override func setUp() {
        super.setUp()
            discoverViewModel = nil
    }
    
    func testDiscoverViewModel_WithMovie_TitleDisplaysCorrectly() {
        discoverViewModel = DiscoverViewModel(movie: Movie.testData())
        XCTAssert(discoverViewModel.title == "Joker")
    }
    
    func testDiscoverViewModel_WithMovie_OverviewDisplaysCorrectly() {
        discoverViewModel = DiscoverViewModel(movie: Movie.testData())
        XCTAssert(discoverViewModel.overview == "Joker overview")
    }
    
    func testDiscoverViewModel_WithMovie_DisplaysRedVoteColor() {
        discoverViewModel = DiscoverViewModel(movie: Movie.testData(voteAverage: 2))
        XCTAssert(discoverViewModel.voteColor == .systemRed)
        
    }
    
    func testDiscoverViewModel_WithMovie_DisplaysOrangeVoteColor() {
        discoverViewModel = DiscoverViewModel(movie: Movie.testData(voteAverage: 4.5))
        XCTAssert(discoverViewModel.voteColor == .systemOrange)
    }
    
    func testDiscoverViewModel_WithMovie_DisplaysGreenVoteColor() {
        discoverViewModel = DiscoverViewModel(movie: Movie.testData(voteAverage: 8))
        XCTAssert(discoverViewModel.voteColor == .systemGreen)
        
    }
    
    func testDiscoverViewModel_WithSeries_TitleDisplaysCorrectly() {
        discoverViewModel = DiscoverViewModel(series: Series.testData())
        XCTAssert(discoverViewModel.title == "The Simpsons")
    }
    
    func testDiscoverViewModel_WithSeries_OverviewDisplaysCorrectly() {
        discoverViewModel = DiscoverViewModel(series: Series.testData())
        XCTAssert(discoverViewModel.overview == "Theeee simpooons")
    }
    
    func testDiscoverViewModel_WithSeries_DisplaysRedVoteColor() {
        discoverViewModel = DiscoverViewModel(series: Series.testData(voteAverage: 2))
        XCTAssert(discoverViewModel.voteColor == .systemRed)
    }
    
    func testDiscoverViewModel_WithSeries_DisplaysOrangeVoteColor() {
        discoverViewModel = DiscoverViewModel(series: Series.testData(voteAverage: 4))
        XCTAssert(discoverViewModel.voteColor == .systemOrange)
    }
    
    func testDiscoverViewModel_WithSeries_DisplaysGreenVoteColor() {
        discoverViewModel = DiscoverViewModel(series: Series.testData(voteAverage: 10))
        XCTAssert(discoverViewModel.voteColor == .systemGreen)
    }
}
