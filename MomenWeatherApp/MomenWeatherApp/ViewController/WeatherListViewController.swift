//
//  WeatherListViewController.swift
//  MomenWeatherApp
//
//  Created by Momen Shataly on 02.11.20.
//

import UIKit
import CoreLocation
import Combine
import MomenWeatherSDK

class WeatherListViewController: BaseViewController {
    
    // MARK: Enumeration
    /// Sections
    enum Section {
        case main
    }
    
    // MARK: UI Constants
    
    enum Constants {
        static let dayCellHeight = CGFloat(174.0)
    }
    
    // MARK: Initialisation
    
    init(viewModel: WeatherListViewModel, coordinatorDelegate: WeatherListViewControllerDelegate? = nil) {
        self.viewModel = viewModel
        self.coordinatorDelegate = coordinatorDelegate
        super.init()
    }
    
    // MARK: - Properties
    // MARK: Mutable
    // MARK: Internal
    
    var viewModel: WeatherListViewModel
    var coordinatorDelegate: WeatherListViewControllerDelegate?
    
    // MARK: Private
    
    private var uiFactory: UIFactory = UIFactory()
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    /**
     * custom background queue to subscribe to combine streams on
     */
    private lazy var backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 5
        return queue
    }()
    
    // MARK: UI Components
    
    private lazy var collectionView: UICollectionView = UIFactory.createCollectionView().with {
        $0.backgroundColor = .systemBackground
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsHorizontalScrollIndicator = false
        $0.alwaysBounceVertical = false
        $0.allowsSelection = true
        $0.collectionViewLayout = createCollectionViewLayout()
    }
    
    /**
     *  a `UILabel` to show city information
     */
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = Theme.Fonts.cityText
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .systemGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    /**
     *  a `UILabel` to show temperature
     */
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = Theme.Fonts.standardBold
        label.numberOfLines = 2
        label.textColor = .systemGray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.fittingSizeLevel, for: .vertical)
        label.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        label.setHorizontalContentHugging(to: .defaultHigh)
        return label
    }()
    
    
    /**
     *  a `UIImageView` to show an icon indicator for the switch
     */
    lazy var liveIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "dot.radiowaves.left.and.right"))
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    /**
     *  a `UIButton` to handle manual refresh action
     */
    lazy var refreshButton: UIButton = {
        let refreshButton = UIButton(primaryAction: refreshAction)
        refreshButton.setImage(UIImage(systemName: "arrow.clockwise.circle"), for: .normal)
        refreshButton.tintColor = Theme.Colors.primary
        return refreshButton
    }()
    
    /**
     *  a data source to be fed to the collectionView that holds the fetched data
     */
    var dataSource: UICollectionViewDiffableDataSource<Section, WeatherDayViewModel>?
    
    /**
     *  an action for handling refresh operation
     */
    lazy var refreshAction: UIAction = UIAction(handler: { [weak self] action in
        guard let self = self else { return }
        self.refreshModel()
        self.refreshButton.isEnabled = false
    })
    
    /**
     *  a `UISwitch` to switch between online and offline mode
     */
    lazy var connectionModeSwitch: UISwitch = {
        var connectionSwitch = UISwitch()
        connectionSwitch.onTintColor = Theme.Colors.primary
        connectionSwitch.isOn = viewModel.isOnline
        connectionSwitch.addAction(UIAction(handler: { [weak self] action in
            guard let sender = action.sender as? UISwitch else { return }
            self?.viewModel.isOnline = sender.isOn
        }), for: .valueChanged)
        return connectionSwitch
    }()
    
    /**
     *  creates a datasource from `UICollectionViewDiffableDataSource` instance.
     *
     *  1) identify `Section` as section class and `WeatherItem` as item class.
     *  2) appends a cellProvider clousure with cell dequeuing and configuring.
     */
    
    private func setupDatasource() {
        // Setup datasource
        dataSource = UICollectionViewDiffableDataSource<Section, WeatherDayViewModel>(
            collectionView: collectionView,
            cellProvider: { (collectionView: UICollectionView,
                             indexPath: IndexPath,
                             identifier: WeatherDayViewModel) -> WeatherDayCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: WeatherDayCell.reuseIdentifier, for: indexPath) as? WeatherDayCell
                cell?.configureWithModel(model: identifier)
                return cell;
            })
    }
    
    
    /**
     *  generates a custom compositional layout for organising items and groups inside the collectionview
     */
    func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(Constants.dayCellHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(Constants.dayCellHeight))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layoutConfiguration = UICollectionViewCompositionalLayoutConfiguration()
        layoutConfiguration.scrollDirection = .vertical
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: layoutConfiguration)
        return layout
    }
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = true
        registerCollectionViewComponents()
        setupDatasource()
        setupSubviews()
        setupConstraints()
        setupBinding()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    // MARK: Private functions
    
    private func registerCollectionViewComponents() {
        collectionView.register(WeatherDayCell.self, forCellWithReuseIdentifier: WeatherDayCell.reuseIdentifier)
    }
    
    private func refreshModel() {
        coordinatorDelegate?.didRequestRefreshModel(viewModel: self.viewModel)
    }
    
    private func setupBinding() {
        viewModel.$weatherList
            .subscribe(on: backgroundQueue)
            .receive(on: RunLoop.main)
            .compactMap { $0 }
            .sink { [weak self] value in
                self?.refreshButton.isEnabled = true
                self?.refreshData()
            }.store(in: &cancellable)
        
        viewModel.$location
            .subscribe(on: backgroundQueue)
            .receive(on: RunLoop.main)
            .compactMap { $0 }
            .sink { [weak self] value in
                self?.refreshButton.isEnabled = false
                self?.refreshModel()
            }.store(in: &cancellable)
        
        viewModel.$isOnline
            .subscribe(on: backgroundQueue)
            .receive(on: RunLoop.main)
            .compactMap { $0 }
            .sink { [weak self] value in
                self?.refreshButton.isEnabled = false
                self?.liveIcon.tintColor = value ? Theme.Colors.primary : .systemGray
                self?.refreshModel()
            }.store(in: &cancellable)
        
    }
    
    private func setupSubviews() {
        [collectionView, cityLabel, refreshButton, liveIcon, connectionModeSwitch, temperatureLabel].forEach { view.addSubview($0) }
    }
    
    private func setupConstraints() {
        collectionView.pinLeadingAndTrailingEdges(to: view.safeAreaLayoutGuide)
        
        cityLabel.pinTopEdge(to: view.safeAreaLayoutGuide, withOffset: Theme.Constants.margin)
        cityLabel.pinLeadingEdge(to: view.safeAreaLayoutGuide, withOffset: Theme.Constants.margin)
        cityLabel.pinTrailingEdgeToLeading(of: temperatureLabel, withOffset: -Theme.Constants.margin)
        cityLabel.pinBottomEdgeToTop(of: collectionView, withOffset: -Theme.Constants.margin)
        
        temperatureLabel.pinTopEdge(to: view.safeAreaLayoutGuide, withOffset: Theme.Constants.margin)
        temperatureLabel.pinTrailingEdge(to: view.safeAreaLayoutGuide, withOffset: -Theme.Constants.margin)
        temperatureLabel.pinBottomEdgeToTop(of: collectionView, withOffset: -Theme.Constants.margin)
        
        connectionModeSwitch.pinTopEdgeToBottom(of: collectionView, withOffset: Theme.Constants.margin)
        connectionModeSwitch.pinBottomEdge(to: view.safeAreaLayoutGuide, withOffset: -Theme.Constants.margin)
        connectionModeSwitch.pinTrailingEdge(to: view.safeAreaLayoutGuide, withOffset: -Theme.Constants.margin)
        
        liveIcon.pinTopEdge(to: connectionModeSwitch)
        liveIcon.pinTrailingEdgeToLeading(of: connectionModeSwitch, withOffset: -Theme.Constants.margin)
        liveIcon.pinBottomEdge(to: connectionModeSwitch)
        
        refreshButton.pinBottomEdge(to: connectionModeSwitch)
        refreshButton.pinTopEdge(to: connectionModeSwitch)
        refreshButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    /**
     * creates a new snapshot from updted viewModel and applys it to datasource
     */
    private func refreshData() {
        cityLabel.text = "\(viewModel.city?.name ?? "" )\n\(viewModel.city?.country ?? "" )"
        guard let currentTemperatures = viewModel.weatherList.sorted(by: \.date, <).first?.weatherList.sorted(by: \.dt, <).first?.main else { return }
        guard let temp = currentTemperatures["temp"] else { return }
        guard let feelsLikeTemp = currentTemperatures["feels_like"] else { return }
        temperatureLabel.text = String(format: "%d°\nfeels like: %d°", Int(ceil(temp)), Int(ceil(feelsLikeTemp)))
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, WeatherDayViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.weatherList.sorted(by: \.date, <))
        dataSource?.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
}

/// Delegate to react when user requests to refresh from data providers
public protocol WeatherListViewControllerDelegate {
    func didRequestRefreshModel(viewModel: WeatherListViewModel)
}


