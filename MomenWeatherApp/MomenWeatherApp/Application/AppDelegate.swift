//
//  AppDelegate.swift
//  MomenWeatherApp
//
//  Created by Momen Shataly on 02.11.20.
//

import UIKit
import MomenWeatherSDK
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainCoordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        startCoordiantor()
        return true
    }
    
    private func startCoordiantor() {
        let navigationController = UINavigationController()
        let apiConfig = APIConfigurableMock()
        let networkProvider = DataProviderMock(decoder: JSONDecoder(), apiConfiguration: apiConfig)
        mainCoordinator = MainCoordinator(dataProvider: networkProvider, presentingViewController: navigationController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        mainCoordinator?.start()
    }
}

