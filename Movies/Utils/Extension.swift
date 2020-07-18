import UIKit

//MARK:- UICollectionView
protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UICollectionViewCell: ReusableView {}

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
}


//MARK:- Bluring
protocol Bluring {
    func addBlur(_ alpha: CGFloat, style: UIBlurEffect.Style)
}

extension Bluring where Self: UIView {
    func addBlur(_ alpha: CGFloat = 0.9, style: UIBlurEffect.Style = .regular) {
        let effect = UIBlurEffect(style: style)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha
        
        addSubview(effectView)
    }
}

extension UIView: Bluring {}


//MARK:- UIView
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat,
                      backgroundColor: UIColor,
                      verticalOffset: Double = -5,
                      shadowOpacity: Float = 0.2) {
        
        let shadowLayer = CAShapeLayer()
        
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        shadowLayer.path = path.cgPath
        shadowLayer.fillColor = backgroundColor.cgColor
        
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: verticalOffset)
        shadowLayer.shadowOpacity = shadowOpacity
        shadowLayer.shadowRadius = 3
        layer.insertSublayer(shadowLayer, at: 0)
    }
}


//MARK:- UIColor
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}


//MARK:- UIImage
extension UIImage {
    class func image(from layer: CALayer) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.bounds.size,
                                               layer.isOpaque, UIScreen.main.scale)
        
        defer { UIGraphicsEndImageContext() }
        
        // Don't proceed unless we have context
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
