//
//  MainCoordinator.swift
//  MomenWeatherApp
//
//  Created by Momen Shataly on 02.11.20.
//

import Foundation
import UIKit
import OpenCombine
import OpenCombineDispatch
import MomenWeatherSDK

private enum MainCoordinatorStep: CoordinatorStep {
    case showMain
    case showLoading
    case hideLoading
    case showError(error: Error)
    case dismiss
    case dismissModal
}

class MainCoordinator: Coordinatable {
    
    // MARK: - Properties
    // MARK: Immutable
    
    private let presentingViewController: UINavigationController?
    private let application: UIApplication
    let identifier: UUID
    
    // MARK: Mutable

    private var reachability: ReachabilityProviding
    private var locationService: LocationService
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    private var networkService: DataProviding
    private var viewModel: WeatherListViewModel?
    var dismissable: CoordinatorDismissable?
    var childCoordinators: [UUID: Coordinatable]

    
    // MARK: Lazy

    private lazy var loadingView: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        guard let navigationController = presentingViewController else { return loader }
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        loader.layer.cornerRadius = 5.0
        navigationController.view.addSubview(loader)
        loader.centerYAnchor.constraint(equalTo: navigationController.view.centerYAnchor).isActive = true
        loader.centerXAnchor.constraint(equalTo: navigationController.view.centerXAnchor).isActive = true
        navigationController.modalPresentationStyle = .overCurrentContext
        loader.startAnimating()
        return loader
    }()

    // MARK: Coordinator protocol

    func coordinate(to step: CoordinatorStep) {
        guard let step = step as? MainCoordinatorStep else { return }
        switch step {

        case .showMain:
            viewModel = WeatherListViewModel()
            guard let viewModel = viewModel else { return }
            let weatherViewController = WeatherListViewController(viewModel: viewModel, coordinatorDelegate: self)
            if presentingViewController?.viewControllers.count ?? 0 > 0 {
                presentingViewController?.present(weatherViewController, animated: true)
            } else {
                presentingViewController?.viewControllers = [weatherViewController]
            }

        case .showError(error: let error):
            coordinate(to: MainCoordinatorStep.hideLoading)

                var errorMessage = error.localizedDescription
                if let localError = error as? HTTPError {
                    errorMessage = "\(localError.errorDescription ?? "").\n\(localError.recoverySuggestion ?? "")"
                }
            let alert = UIFactory.createConfirmAlertView(title: "Error", message: errorMessage)
            self.presentingViewController?.present(alert, animated: true, completion: nil)

        case .dismiss:
            dismiss()
        case .dismissModal:
            dismissModal()
        case .showLoading:
            self.loadingView.startAnimating()
            break;
        case .hideLoading:
            self.loadingView.stopAnimating()
            break
        }
    }


    func start() {
        startReachabilityService()
        startLocationService()
        coordinate(to: MainCoordinatorStep.showMain)
    }
    
    private func dismiss() {
        presentingViewController?.dismiss(animated: true) { [weak self] in
            self?.finish()
        }
    }
    
    private func dismissModal() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

    // MARK: Initialisers

    init(identifier: UUID = UUID(),
         dataProvider: DataProviding,
         presentingViewController: UINavigationController?,
         application: UIApplication = UIApplication.shared,
         childCoordinators: [UUID: Coordinatable] = [:],
         reachability: ReachabilityProviding = Reachability(),
         locationService: LocationProviding = LocationService()) {
        self.identifier = identifier
        self.presentingViewController = presentingViewController
        self.application = application
        self.childCoordinators = childCoordinators
        self.networkService = dataProvider
        self.reachability = reachability
        self.locationService = locationService as! LocationService
    }

    // MARK: Private functions
    
    private func loadWeather(ofViewModel: WeatherListViewModel) {
        self.coordinate(to: MainCoordinatorStep.showLoading)

        if ofViewModel.isOnline {
            let apiConfiguration = APIConfiguration()
            networkService = DataProvider(decoder: JSONDecoder(), apiConfiguration: apiConfiguration)
        } else {
            let apiConfiguration = APIConfigurableMock()
            networkService = DataProviderMock(decoder: JSONDecoder(), apiConfiguration: apiConfiguration)
        }
        
        do {
            try networkService.loadWeather(for: ofViewModel.location)
                .subscribe(on: RunLoop.current.ocombine)
                .receive(on: RunLoop.main.ocombine)
                .mapError { $0 as Error }
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        self.coordinate(to: MainCoordinatorStep.hideLoading)
                        break
                    case .failure(let error):
                        self.coordinate(to: MainCoordinatorStep.showError(error: error))
                        ofViewModel.weatherList = []
                    }
                }) { value in
                    ofViewModel.weatherList = value.list.sliced(by: [.day, .month, .year], for: \.dt)
                        .map { .init(date: $0, weatherList: $1) }
                    ofViewModel.city = value.city
                    ofViewModel.date = Date()
                }.store(in: &cancellable)
        } catch {
            self.coordinate(to: MainCoordinatorStep.hideLoading)
            self.coordinate(to: MainCoordinatorStep.showError(error: error))
        }
    }

    private func startReachabilityService() {
        reachability.isConnectedToNetwork
            .subscribe(on: RunLoop.current.ocombine)
            .receive(on: RunLoop.main.ocombine)
            .sink { completion in
                switch completion {
                case .failure(let error as LocalizedError):
                    self.coordinate(to: MainCoordinatorStep.showError(error: error))
                case .finished:
                    print("subscribed to reachability..")
                }
            } receiveValue: { isConnected in
                if isConnected == false {
                    self.coordinate(to: MainCoordinatorStep.showError(error: ReachabilityError.deviceIsNotConnected ))
                }
            }.store(in: &cancellable)
    }

    private func startLocationService() {
        if locationService.hasLocationAuthorized == false {
            locationService.authorizeLocationService()
        }
        locationService.startMonitoringLocation()
        locationService.currentLocation
            .subscribe(on: RunLoop.current.ocombine)
            .receive(on: RunLoop.main.ocombine)
            .sink { completion in
                switch completion {
                case .finished:
                    print("subscribed to locationService..")
                case .failure(let error):
                    self.coordinate(to: MainCoordinatorStep.showError(error: error))
                    break
                }
            } receiveValue: { [weak self] value in
                // set location to viewModel to show current location's weather
                self?.viewModel?.location = value
            }.store(in: &cancellable)
    }
}

extension MainCoordinator: WeatherListViewControllerDelegate {

    func didRequestRefreshModel(viewModel: WeatherListViewModel) {
        self.loadWeather(ofViewModel: viewModel)
    }
}
