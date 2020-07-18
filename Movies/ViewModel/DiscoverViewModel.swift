import UIKit

struct DiscoverViewModel: Hashable {
    let title: String
    var imageURL: URL?
    let overview: String
    private let voteAverage: Float
    var voteColor: UIColor {
        switch voteAverage {
        case let x where x < 3:
            return .systemRed
        case let x where  4...5 ~= x:
            return .systemOrange
        default:
            return .systemGreen
        }
    }
    
    var ratingTextFormatted: NSMutableAttributedString {
        let firstString = NSMutableAttributedString(string: NSLocalizedString("Ratings: ", comment: ""), attributes: [.font: UIFont.systemFont(ofSize: 15)])
        let secondString = NSAttributedString(string: voteAverage.description, attributes: [.font: UIFont.boldSystemFont(ofSize: 20),
                                                                                            .foregroundColor: voteColor])
        firstString.append(secondString)
        return firstString
    }
    
    init(movie: Movie) {
        title = movie.title
        imageURL = movie.imageURL
        overview = movie.overview
        voteAverage = movie.voteAverage
    }
    
    init(series: Series) {
        title = series.name
        imageURL = series.imageURL
        overview = series.overview
        voteAverage = series.voteAverage
    }
}
