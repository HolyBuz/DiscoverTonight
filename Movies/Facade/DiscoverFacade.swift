import Foundation

protocol DiscoverFacade {
    func getMovies(completion: @escaping (Result<[DiscoverViewModel], Error>) -> ())
    func getSeries(completion: @escaping (Result<[DiscoverViewModel], Error>) -> ())
    
    var isFetchingNextPage: Bool { get }
}

class DiscoverFacadeImpl: DiscoverFacade {
    private let discoverService: DiscoverService
    private var moviesTotalPages: Int = .max
    private var moviesCurrentPage = 1
    private var seriesTotalPages: Int = .max
    private var seriesCurrentPage = 1
    private var isFetching = false
    
    var isFetchingNextPage : Bool {
        return isFetching
    }
    
    init(service: Service) {
        discoverService = service.discoverService
    }
    
    func getMovies(completion: @escaping (Result<[DiscoverViewModel], Error>) -> ()) {
        guard moviesCurrentPage <= moviesTotalPages else { return }
        
        isFetching = true
        
        discoverService.getMovies(page: moviesCurrentPage) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movieList):
                    self?.moviesCurrentPage += 1
                    self?.moviesTotalPages = movieList.totalPages
                    
                    completion(.success(movieList.results.map(DiscoverViewModel.init)))
                case .failure(let error):
                    completion(.failure(error))
                }
                
                self?.isFetching = false
            }
        }
    }
    
    func getSeries(completion: @escaping (Result<[DiscoverViewModel], Error>) -> ()) {
        guard seriesCurrentPage <= seriesTotalPages else { return }
        
        isFetching = true
        
        discoverService.getSeries(page: seriesCurrentPage) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let seriesList):
                    self?.seriesCurrentPage += 1
                    self?.seriesTotalPages = seriesList.totalPages
                    
                    completion(.success(seriesList.results.map(DiscoverViewModel.init)))
                case .failure(let error):
                    completion(.failure(error))
                }
                
                self?.isFetching = false
            }
        }
    }
}

