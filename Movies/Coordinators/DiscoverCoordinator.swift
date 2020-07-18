import UIKit

final class DiscoverCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    
    override init() {
        self.navigationController = GradientNavigationViewController()
    }
    
    var childCoordinators = [Coordinator]()
    
    func start() {
        let service = CoreService()
        let facade = DiscoverFacadeImpl(service: service)
        let moviesViewController = DiscoverViewController(facade: facade, coordinator: self)
        navigationController.viewControllers = [moviesViewController]
    }
    
    func toMovieDetail(with movieViewModel: DiscoverViewModel) {
        let movieDetailViewController = DetailsViewController()
        movieDetailViewController.update(with: movieViewModel)
        navigationController.pushViewController(movieDetailViewController, animated: true)
    }
    
    private func childCoordinatorDidFinish(_ child: Coordinator?) {
        childCoordinators.removeAll(where: {child === $0})
        navigationController.popToRootViewController(animated: true)
    }
}

