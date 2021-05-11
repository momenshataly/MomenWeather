//
//  APIConfigurable.swift
//  MomenWeatherSDK
//
//  Created by Momen Shataly on 01.11.20.
//

import Foundation
import CoreLocation

/// we use one endpoint so far
public enum Endpoint {
    
    /// veichels endpoint to get the list of pois
    case weatherFiveDaysThreeHourInterval
}

/// a class that implements generation of api endpoint urls
public protocol APIConfigurable {
    
    /// host without scheme
    var host: String { get }
    /// app id
    var appId: String { get }
    /// api version
    var apiVersion: String { get }
    /// unit
    var units: String { get }
    
    /// building an api request url from given parameters
    func buildURL(_: Endpoint, coordinate: CLLocationCoordinate2D) throws -> URL
}

