@testable import Movies

extension Series {
    static func testData(voteAverage: Float = 7.0) -> Series {
        return Series(name: "The Simpsons",
                     posterPath: "/3wZ0gxLqsPleneFSTZILmM3BE8Q.jpg",
                     overview: "Theeee simpooons",
                     voteAverage: voteAverage)
    }
}

extension Movie {
    static func testData(voteAverage: Float = 7.0) -> Movie {
        return Movie(title: "Joker",
                     posterPath: "/3wZ0gxLqsPleneFSTZILmM3BE8Q.jpg",
                     overview: "Joker overview",
                     voteAverage: voteAverage)
    }
}

extension DiscoverViewModel {
    static func testData() -> DiscoverViewModel {
        return DiscoverViewModel(movie: Movie.testData())
    }
}
