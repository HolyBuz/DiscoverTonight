import XCTest
@testable import Movies

final class MockDiscoverService: DiscoverService {
    var movieListResponse: Result<MovieList, Error>!
    var seriesListResponse: Result<SeriesList, Error>!
    
    
    func getMovies(page: Int, completion: @escaping (Result<MovieList, Error>) -> ()) {
       DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            switch self.movieListResponse {
            case .success(let movieList):
                completion(.success(movieList))
            case .failure(let error):
                completion(.failure(error))
            case .none: ()
            }
        }
    }
    
    func getSeries(page: Int, completion: @escaping (Result<SeriesList, Error>) -> ()) {
       DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            switch self.seriesListResponse {
            case .success(let serieList):
                completion(.success(serieList))
            case .failure(let error):
                completion(.failure(error))
            case .none: ()
            }
        }
        
    }
}
