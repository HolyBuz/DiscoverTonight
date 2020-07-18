import UIKit

class GradientNavigationViewController: UINavigationController {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        navigationBar.addSubview(view)
        navigationBar.sendSubviewToBack(view)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        applyGradient()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    ///https://uigradients.com/#Wiretap
    private let gradientColors = [UIColor(rgb: 0x8a2387), UIColor(rgb: 0xe94057), UIColor(rgb: 0xf27121)]
    private let gradientLocations = [0.0, 0.5, 1.0]
    
    private func applyGradient() {
        let height = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        backgroundView.frame = CGRect(x: 0, y: -height, width: navigationBar.frame.width, height: height)
        backgroundView.backgroundColor = UIColor(patternImage: gradientImage(for: navigationBar))
        
        navigationBar.setBackgroundImage(gradientImage(for: navigationBar), for: .default)
        navigationBar.layer.backgroundColor = UIColor(patternImage: gradientImage(for: navigationBar)).cgColor
    }
    
    private func setupView() {
        navigationBar.barStyle = .default
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        navigationBar.prefersLargeTitles = true
        navigationBar.tintColor = UIColor.white
        navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func gradientImage(for view: UIView) -> UIImage {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = gradientColors.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.locations = gradientLocations as [NSNumber]
        gradient.cornerRadius = view.layer.cornerRadius
        let image = UIImage.image(from: gradient)?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: navigationBar.frame.size.width/2, bottom: 10, right: navigationBar.frame.size.width/2),resizingMode: .stretch)
        return image ?? UIImage()
    }
}

