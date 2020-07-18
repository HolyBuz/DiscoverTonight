import UIKit
import SDWebImage

final class DetailsViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+300)
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .clear
        containerView.isUserInteractionEnabled = true
        return containerView
    }()
    
    private let blurImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .thin)
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .thin)
        return label
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupHierarchy() {
        containerView.addSubview(blurImageView)
        containerView.addSubview(posterImageView)
        containerView.addSubview(overviewLabel)
        containerView.addSubview(ratingLabel)
        scrollView.addSubview(containerView)
        view.addSubview(scrollView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            blurImageView.heightAnchor.constraint(equalToConstant: 400),
            blurImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            blurImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            blurImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            
            posterImageView.centerYAnchor.constraint(equalTo: blurImageView.centerYAnchor),
            posterImageView.centerXAnchor.constraint(equalTo: blurImageView.centerXAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 400),
    
            overviewLabel.topAnchor.constraint(equalTo: blurImageView.bottomAnchor, constant: ViewConstants.mediumMargin),
            overviewLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewConstants.mediumMargin),
            overviewLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ViewConstants.mediumMargin),
            
            ratingLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: ViewConstants.mediumMargin),
            ratingLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewConstants.mediumMargin),
            containerView.bottomAnchor.constraint(equalTo: ratingLabel.bottomAnchor)
        ])
    }
    
    func update(with viewModel: DiscoverViewModel) {
        overviewLabel.text = viewModel.overview
        ratingLabel.attributedText = viewModel.ratingTextFormatted
        title = viewModel.title
        
        posterImageView.sd_setImage(with: viewModel.imageURL, completed:  { [weak self] image, error, _, _ in
            self?.blurImageView.image = image
            self?.blurImageView.addBlur()
            
            guard error != nil else { return }
        })
    }
}
