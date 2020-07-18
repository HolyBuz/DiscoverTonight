import UIKit

class DiscoverSectionHeader: UICollectionReusableView {
    static let reuseIdentifier = "MoviesSectionHeader"

    private let sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Stop trying to make storyboards happen.")
    }
    
    private func setupView() {
        roundCorners(corners: [.topLeft, .topRight], radius: 20, backgroundColor: .systemBackground)
    }

    private func setupHierarchy() {
        addSubview(sectionTitleLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            sectionTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewConstants.mediumMargin),
            sectionTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewConstants.mediumMargin),
            sectionTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ViewConstants.mediumMargin),
            sectionTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewConstants.mediumMargin)
        ])
    }
    
    func update(with sectionTitle: String) {
        sectionTitleLabel.text = sectionTitle
    }
}
