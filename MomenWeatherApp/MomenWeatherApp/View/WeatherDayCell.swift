//
//  WeatherItemCell.swift
//  MomenWeatherApp
//
//  Created by Momen Shataly on 06.11.20.
//

import UIKit
import MomenWeatherSDK

class WeatherDayCell: UICollectionViewCell, UICollectionViewDelegate {
    
    enum Section {
        case main
    }

    enum Constants {
        static let cellHeight: CGFloat = 120
        static let dateLabelHeight: CGFloat = 30
        static let cellWidth: CGFloat = 100
    }
    
    
    static let reuseIdentifier = "weatherItemCell"
    
    var model: WeatherDayViewModel?
    var dataSource: UICollectionViewDiffableDataSource<Section, WeatherItem>?
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = Theme.Fonts.dateText
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.textColor = .systemGray
        label.contentMode = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.font = Theme.Fonts.standard
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var collectionView: UICollectionView = {
        
        let collectionView = UIFactory.createCollectionView()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceVertical = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsSelection = false
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        
        return collectionView
    }()
    
    public func configureWithModel(model: WeatherDayViewModel) {
        self.model = model
        dateLabel.text = model.date.dateString
        setupDataSource()
        refreshData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: WeatherCell.reuseIdentifier)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetData()
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, WeatherItem>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.reuseIdentifier, for: indexPath) as? WeatherCell else { return nil }
            cell.configureWithModel(model: item)
            return cell
        })
    }
    
    
    private func setupConstraints() {
        collectionView.pinTopEdgeToBottom(of: dateLabel, withOffset: Theme.Constants.padding)
        collectionView.pinLeadingAndTrailingEdges(to: self, withOffset: Theme.Constants.padding)
        collectionView.pinBottomEdge(to: self, withOffset: -Theme.Constants.padding)
        dateLabel.pinTopEdge(to: self, withOffset: Theme.Constants.padding)
        dateLabel.pinLeadingAndTrailingEdges(to: self, withOffset: Theme.Constants.padding)
        collectionView.pinHeight(to: Constants.cellHeight)
        dateLabel.pinHeight(to: Constants.dateLabelHeight)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: Constants.cellWidth, height: Constants.cellHeight)
        
        collectionView.collectionViewLayout = layout
    }
    
    private func refreshData() {
        guard let dataSource = dataSource else { return }
        var snapshot = NSDiffableDataSourceSnapshot<Section, WeatherItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.model?.weatherList ?? [])
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func setupViews() {
        [dateLabel, collectionView].forEach(addSubview(_:))
        self.clipsToBounds = true
        self.bringSubviewToFront(dateLabel)
    }

    private func resetData() {
        guard let dataSource = dataSource else { return }
        var snapshot = NSDiffableDataSourceSnapshot<Section, WeatherItem>()
        snapshot.deleteAllItems()
        dataSource.apply(snapshot, animatingDifferences: false)
        dateLabel.text = nil
    }
    
}
