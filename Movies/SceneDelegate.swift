import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let moviesCoordinator = DiscoverCoordinator()
        moviesCoordinator.start()
        
        window?.rootViewController = moviesCoordinator.navigationController
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }
}
