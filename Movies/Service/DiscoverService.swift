protocol DiscoverService {
    func getMovies(page: Int, completion: @escaping (Result<MovieList, Error>) -> ())
    func getSeries(page: Int, completion: @escaping (Result<SeriesList, Error>) -> ())
}

final class DiscoverServiceImpl: DiscoverService {
    
    private let backend: Backend
    
    init(backend: Backend) {
        self.backend = backend
    }
    
    func getMovies(page: Int, completion: @escaping (Result<MovieList, Error>) -> ()) {
        let parameters = ["page": page.description]
        let resource = Resource(path: "discover/movie", parameters: parameters)
    
        backend.request(resource, type: MovieList.self) { (result) in
            switch result {
                case .success(let movies):
                    completion(.success(movies))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func getSeries(page: Int, completion: @escaping (Result<SeriesList, Error>) -> ()) {
        let parameters = ["page": page.description]
        let resource = Resource(path: "discover/tv", parameters: parameters)
        
        backend.request(resource, type: SeriesList.self) { (result) in
            switch result {
                case .success(let series):
                    completion(.success(series))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
