import Foundation
@testable import Movies

final class MockDiscoverFacade: DiscoverFacade {
    var isFetchingNextPage = false
    var shouldReturnError = false
    
    var mockDiscoverService: MockDiscoverService
    
    init() {
        self.mockDiscoverService = MockDiscoverService()
    }
    
    func getMovies(completion: @escaping (Result<[DiscoverViewModel], Error>) -> ()) {
        isFetchingNextPage = true
        
        DispatchQueue.main.async { [unowned self] in
            if self.shouldReturnError {
                completion(.failure(NSError(domain: "This should fail", code: 400, userInfo: nil)))
            } else {
                self.mockDiscoverService.getMovies(page: 1, completion: { response in
                    switch response {
                    case .success(let movieList):
                        completion(.success(movieList.results.map(DiscoverViewModel.init)))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
            }
            self.isFetchingNextPage = false
        }
    }
    
    func getSeries(completion: @escaping (Result<[DiscoverViewModel], Error>) -> ()) {
        isFetchingNextPage = true
        
        DispatchQueue.main.async { [unowned self] in
            if self.shouldReturnError {
                completion(.failure(NSError(domain: "This should fail", code: 400, userInfo: nil)))
            } else {
                self.mockDiscoverService.getSeries(page: 1, completion: { response in
                    switch response {
                    case .success(let movieList):
                        completion(.success(movieList.results.map(DiscoverViewModel.init)))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
            }
            self.isFetchingNextPage = false
        }
    }
}

