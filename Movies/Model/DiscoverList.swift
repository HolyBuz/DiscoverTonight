struct MovieList: Decodable {
    var page: Int
    var results: [Movie]
    var totalResults: Int
    var totalPages: Int
}

struct SeriesList: Decodable {
    var page: Int
    var results: [Series]
    var totalResults: Int
    var totalPages: Int
}


