import Foundation

struct Series: Decodable {
    let name: String
    let posterPath: String?
    let overview: String
    let voteAverage: Float
    
    var imageURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w300" + posterPath)
    }
}
