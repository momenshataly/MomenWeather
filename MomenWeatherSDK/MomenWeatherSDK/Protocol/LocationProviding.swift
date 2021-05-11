//
//  LocationProviding.swift
//  MomenWeatherSDK
//
//  Created by Momen Shataly on 01.11.20.
//

import Foundation
import CoreLocation

public protocol LocationProviding {
    func startMonitoringLocation()
    func stopMonitoringLocation()
    func authorizeLocationService()
}
