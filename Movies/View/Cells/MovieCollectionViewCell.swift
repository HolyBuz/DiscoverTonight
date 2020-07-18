import UIKit
import SDWebImage

final class MovieCollectionViewCell: UICollectionViewCell {

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.backgroundColor = .systemBackground
    }
    
    private func setupHierarchy() {
        contentView.addSubview(imageView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    func update(with viewModel: DiscoverViewModel) {
        imageView.sd_setImage(with: viewModel.imageURL)
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
}

