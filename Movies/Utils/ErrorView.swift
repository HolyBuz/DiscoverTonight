import UIKit

protocol ErrorViewDelegate: class {
    func didTapRetryButton()
}

final class ErrorView: UIView {
    
    private var mainVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "exclamationmark.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var textLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Sorry, no data for this element!", comment: "")
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var retryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Retry", for: .normal)
        button.addTarget(self, action: #selector(didTapRetryButton), for: .touchUpInside)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: ErrorViewDelegate?
    
    init(shouldHideImage: Bool = false) {
        super.init(frame: .zero)
        
        setupViews()
        setupHierarchy()
        setupLayout()
        
        imageView.isHidden = shouldHideImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 20
        isHidden = true
        translatesAutoresizingMaskIntoConstraints =  false
    }
    
    private func setupHierarchy() {
        mainVerticalStackView.addArrangedSubview(imageView)
        mainVerticalStackView.addArrangedSubview(textLabel)
        
        addSubview(mainVerticalStackView)
        addSubview(retryButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            retryButton.widthAnchor.constraint(equalToConstant: 70),
            retryButton.heightAnchor.constraint(equalToConstant: 50),
            retryButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -ViewConstants.mediumMargin),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            mainVerticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: ViewConstants.mediumMargin),
            mainVerticalStackView.bottomAnchor.constraint(equalTo: retryButton.topAnchor, constant: -ViewConstants.mediumMargin),
            mainVerticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainVerticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    @objc private func didTapRetryButton() {
        isHidden = true
        delegate?.didTapRetryButton()
    }
    
    func update(with error: Error) {
        isHidden = false
        textLabel.text = error.localizedDescription
    }
}
