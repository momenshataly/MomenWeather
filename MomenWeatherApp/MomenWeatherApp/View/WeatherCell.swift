//
//  WeatherCell.swift
//  MomenWeatherApp
//
//  Created by Momen Shataly on 06.11.20.
//

import UIKit
import MomenWeatherSDK
import Combine

class WeatherCell: UICollectionViewCell {
    
    struct Constants {
        static let animationDuration = TimeInterval(0.3)
        static let iconHeight: CGFloat = 50.0
        static let hourLabelHeightMultiplier: CGFloat = 0.2
    }
    
    static let reuseIdentifier = "weatherCell"
    private var cancellable: AnyCancellable?
    private var animator: UIViewPropertyAnimator?
    
    private lazy var iconImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "photo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var temperatureLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.Fonts.standard
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    lazy var hourLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.Fonts.standard
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImage.alpha = 0.0
        if animator?.state == .active { animator?.stopAnimation(true) }
        cancellable?.cancel()
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    public func configureWithModel(model: WeatherItem) {
        // why they have weather info as an array ?? idk..
        guard let weather = model.weather.first else { return }
        guard let temp = model.main["temp"] else { return }
        guard let feelsLikeTemp = model.main["feels_like"] else { return }
        let date = Date(timeIntervalSince1970: model.dt)
        
        temperatureLabel.text = String(format: "%d° C\n(feels like: %d° C)", Int(ceil(temp)), Int(ceil(feelsLikeTemp)))
        hourLabel.text = "\(date.timeHourString)"
        cancellable = loadImage(for: weather).sink { [unowned self] image in self.showImage(image: image) }
    }

    private func setupSubviews() {
        [hourLabel, temperatureLabel, iconImage].forEach(addSubview(_:))
        self.backgroundColor = .systemBackground
    }

    private func setupConstraints() {

        hourLabel.pinTopEdge(to: self)
        hourLabel.pinLeadingAndTrailingEdges(to: self)
        hourLabel.pinWidth(to: self)
        hourLabel.pinHeight(to: self, multipliedBy: Constants.hourLabelHeightMultiplier)
        hourLabel.pinBottomEdgeToTop(of: iconImage)

        iconImage.pinHeight(to: Constants.iconHeight)
        iconImage.pinWidth(to: self)
        iconImage.pinLeadingAndTrailingEdges(to: self)
        iconImage.pinBottomEdgeToTop(of: temperatureLabel)


        temperatureLabel.pinLeadingAndTrailingEdges(to: self)
        temperatureLabel.pinWidth(to: self)
        temperatureLabel.pinBottomEdge(to: self)

    }
    
    private func showImage(image: UIImage?) {
        iconImage.alpha = 0.0
        if animator?.state == .active { animator?.stopAnimation(true) }
        iconImage.image = image
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: Constants.animationDuration, delay: 0, options: .curveLinear, animations: {
            self.iconImage.alpha = 1.0
        })
        
        animator?.addCompletion { [weak self] _ in
            self?.animator = nil
        }
    }
    
    private func loadImage(for weather: Weather) -> AnyPublisher<UIImage?, Never> {
        guard let thumbnail = weather.$icon.iconImageUrl else { return Just(UIImage(systemName: "photo")).eraseToAnyPublisher() }
        return Just(thumbnail)
            .flatMap({ thumbnail -> AnyPublisher<UIImage?, Never> in
                return ImageLoader.shared.loadImage(from: thumbnail)
            })
            .eraseToAnyPublisher()
    }
    
}
