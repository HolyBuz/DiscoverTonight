import Foundation

protocol DiscoverFacade {
    func getMovies(completion: @escaping (Result<[DiscoverViewModel], Error>) -> ())
    func getSeries(completion: @escaping (Result<[DiscoverViewModel], Error>) -> ())
    
    var isFetchingNextPage: Bool { get }
}

class MoviesFacadeImpl: DiscoverFacade {
    private let discoverService: DiscoverService
    private var moviesTotalPages: Int = .max
    private var moviesCurrentPage = 1
    private var seriesTotalPages: Int = .max
    private var seriesCurrentPage = 1
    private var isFetching = false
    
    var isFetchingNextPage : Bool {
        return isFetching
    }
    
    init(service: CoreService) {
        discoverService = service.discoverService
    }
    
    func getMovies(completion: @escaping (Result<[DiscoverViewModel], Error>) -> ()) {
        guard moviesCurrentPage <= moviesTotalPages else { return }
        
        isFetching = true
        
        discoverService.getMovies(page: moviesCurrentPage) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let filmList):
                    self?.moviesCurrentPage += 1
                    self?.moviesTotalPages = filmList.totalPages
                    
                    completion(.success(filmList.results.map(DiscoverViewModel.init)))
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
    
    private func resetPages(){
        moviesCurrentPage = 1
        moviesTotalPages = .max
        
        seriesCurrentPage = 1
        seriesTotalPages = .max
    }
}

