//
//  DataProviding.swift
//  MomenWeatherSDK
//
//  Created by Momen Shataly on 01.11.20.
//

import Foundation
import CoreLocation
import OpenCombine
/// protocol generalization for api data provider
public protocol DataProviding {
    func loadWeather(for coordinate: CLLocationCoordinate2D) throws -> AnyPublisher<WeatherForcastResult, Error>
}
