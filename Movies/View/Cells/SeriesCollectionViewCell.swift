import UIKit
import SDWebImage

final class SeriesCollectionViewCell: UICollectionViewCell {

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.3
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
    
    private func setupView() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12.0
        contentView.layer.masksToBounds = true
    }
    
    private func setupHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewConstants.smallMargin),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ViewConstants.smallMargin),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -ViewConstants.mediumMargin),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func update(with viewModel: DiscoverViewModel) {
        titleLabel.text = viewModel.title
    
        imageView.sd_setImage(with: viewModel.imageURL)
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        imageView.image = nil
    }
}

