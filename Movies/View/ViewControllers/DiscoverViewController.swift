import UIKit

//MARK:- Section
extension DiscoverViewController {
    fileprivate enum Section: Int, CaseIterable, CustomStringConvertible {
        case movies
        case series
        
        var description: String {
            switch self {
            case .movies: return "Movies"
            case .series: return "Series"
            }
        }
    }
}

class DiscoverViewController: UIViewController {
    private let errorView = ErrorView()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.clipsToBounds = false
        collectionView.register(MovieCollectionViewCell.self)
        collectionView.register(SeriesCollectionViewCell.self)
        collectionView.register(DiscoverSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DiscoverSectionHeader.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private var sectionViewModels: [[DiscoverViewModel]] = Section.allCases.map { _ in [DiscoverViewModel]() }
    private let facade: DiscoverFacade
    private let coordinator: DiscoverCoordinator
    
    init(facade: DiscoverFacade, coordinator: DiscoverCoordinator) {
        self.facade = facade
        self.coordinator = coordinator
        
        super.init(nibName: nil, bundle: nil)
        
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        errorView.delegate = self
        
        view.backgroundColor = .systemBackground
        title = NSLocalizedString("Discover", comment: "")
    }
    
    private func setupHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(errorView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ViewConstants.smallMargin),
            errorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -ViewConstants.smallMargin),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ViewConstants.mediumMargin),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ViewConstants.smallMargin),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -ViewConstants.smallMargin),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshMovies()
        refreshSeries()
    }

    private func update(section: Section, with viewModels: [DiscoverViewModel]) {
        sectionViewModels[section.rawValue].append(contentsOf: viewModels)
        collectionView.reloadData()
    }
    
    private func update(with error: Error) {
        errorView.update(with: error)
    }
    
    private func refreshMovies() {
        facade.getMovies { [weak self] result in
            switch result {
            case .success(let viewModels):
                self?.update(section: .movies, with: viewModels)
            case .failure(let error):
                self?.update(with: error)
            }
        }
    }
    
    private func refreshSeries() {
        facade.getSeries { [weak self] result in
            switch result {
            case .success(let viewModels):
                self?.update(section: .series, with: viewModels)
            case .failure(let error):
                self?.update(with: error)
            }
        }
    }
}

//MARK:- UICollectionViewDataSource
extension DiscoverViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionViewModels[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Section.allCases[indexPath.section] {
        case .movies:
            let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.update(with: sectionViewModels[indexPath.section][indexPath.item])
            return cell
        case .series:
            let cell: SeriesCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.update(with: sectionViewModels[indexPath.section][indexPath.item])
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DiscoverSectionHeader.reuseIdentifier, for: indexPath) as? DiscoverSectionHeader else {
                   fatalError("Could not dequeue SectionHeader")
               }
        
        headerView.update(with: Section.allCases[indexPath.section].description)
        return headerView
    }
}

//MARK:- UICollectionViewDelegate
extension DiscoverViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator.toMovieDetail(with: sectionViewModels[indexPath.section][indexPath.item])
    }
}

//MARK:- Compositional Layout
extension DiscoverViewController {
    private var compositionalLayout: UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [unowned self] sectionIndex, _ in
            switch Section.allCases[sectionIndex] {
            case .movies:
                 return self.moviesSection
            case .series:
                return self.seriesSection
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = ViewConstants.sectionSpacing
        layout.configuration = config
        return layout
    }
    
    private var moviesSection: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: ViewConstants.bigCellSpacing, leading: ViewConstants.bigCellSpacing, bottom: ViewConstants.bigCellSpacing, trailing: ViewConstants.bigCellSpacing)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(ViewConstants.cellHeight))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        layoutSection.boundarySupplementaryItems = [sectionHeader]
        
        //Pagination
        layoutSection.visibleItemsInvalidationHandler = { [weak self] visibleItems, _, _ in
            guard
                let self = self,
                let row = visibleItems.last?.indexPath.row,
                row >= self.sectionViewModels[Section.movies.rawValue].count - 1 && !self.facade.isFetchingNextPage else { return }
                
            self.refreshMovies()
        }
        
        return layoutSection
    }
    
    private var seriesSection: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: ViewConstants.smallCellSpacing, leading: ViewConstants.smallCellSpacing, bottom: ViewConstants.smallCellSpacing, trailing: ViewConstants.smallCellSpacing)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(0.4))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuous
        layoutSection.boundarySupplementaryItems = [sectionHeader]
        
        //Pagination
        layoutSection.visibleItemsInvalidationHandler = { [weak self] visibleItems, _, _ in
            guard let self = self, let row = visibleItems.last?.indexPath.row else { return }
            
            if row >= self.sectionViewModels[Section.series.rawValue].count - 1 && !self.facade.isFetchingNextPage {
                self.refreshSeries()
            }
        }
        
        return layoutSection
    }
    
    private var sectionHeader: NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
}

//MARK:- ErrorViewDelegate
extension DiscoverViewController: ErrorViewDelegate {
    func didTapRetryButton() {
        refreshMovies()
        refreshSeries()
    }
}
