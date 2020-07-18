import Foundation

struct Movie: Decodable {
    let title: String
    let posterPath: String?
    let overview: String
    let voteAverage: Float
    
    var imageURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w300" + posterPath)
    }
}
