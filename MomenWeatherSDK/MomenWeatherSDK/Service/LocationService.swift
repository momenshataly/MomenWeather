//
//  LocationService.swift
//  MomenWeatherApp
//
//  Created by Momen Shataly on 06.11.20.
//

import Foundation
import CoreLocation
import OpenCombine

/**
 *  Provides location monitoring information with a combine wrapper
 */
public class LocationService: NSObject, LocationProviding {

    // MARK: Properties
    // MARK: - Internal

    internal var locationSubject: PassthroughSubject<CLLocationCoordinate2D, Error>
    internal var locationManager: CLLocationManager?

    // MARK: - Public

    public var currentLocation: AnyPublisher<CLLocationCoordinate2D, Error>

    // MARK: - Computed

    public var hasLocationAuthorized: Bool {
        self.locationManager?.authorizationStatus == .authorizedAlways || self.locationManager?.authorizationStatus == .authorizedWhenInUse
    }

    // MARK: Initialiser

    public init(locationManager: CLLocationManager = CLLocationManager()) {
        locationSubject = PassthroughSubject<CLLocationCoordinate2D, Error>()
        currentLocation = locationSubject.eraseToAnyPublisher()
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.activityType = .other
        self.locationManager = locationManager
        self.locationManager?.delegate = self
    }

    // MARK: Public functions

    public func startMonitoringLocation() {
        if hasLocationAuthorized {
            locationManager?.startUpdatingLocation()
        }
    }

    public func stopMonitoringLocation() {
        if hasLocationAuthorized {
            locationManager?.stopUpdatingLocation()
        }
    }

    public func authorizeLocationService() {
        locationManager?.requestWhenInUseAuthorization()
    }
}

// MARK: CLLocationManagerDelegate

extension LocationService: CLLocationManagerDelegate {

    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("changed authorization location to \(manager.authorizationStatus)")
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.forEach{ locationSubject.send($0.coordinate) }
    }

    public func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        locationSubject.send(completion: .finished)
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationSubject.send(completion: .failure(error))
    }
}
