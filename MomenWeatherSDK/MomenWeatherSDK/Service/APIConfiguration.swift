//
//  APIConfiguration.swift
//  MomenWeatherSDK
//
//  Created by Momen Shataly on 06.11.20.
//

import Foundation
import CoreLocation

/// holds a collection of api configurations that is used to create configure api connectivity and data manipulations
public class APIConfiguration: NSObject, APIConfigurable {

    /// defaults for ease of use
    public struct Defaults {
        public static let host = "api.openweathermap.org"
        public static let apiVersion = "2.5"
        public static let appId = "bbb674275d99c25538e5c9ee9b327d2e"
        public static let units = "metric"
    }

    /// host without scheme i.e. gateway.marvel.com
    public let host: String
    /// api version
    public let apiVersion: String
    /// app id
    public let appId: String
    /// default unit to show degrees
    public let units: String

    public required init(host: String = Defaults.host,
                         appId: String = Defaults.appId,
                         apiVersion: String = Defaults.apiVersion,
                         units: String = Defaults.units) {
        self.host = host
        self.appId = appId
        self.apiVersion = apiVersion
        self.units = units
    }

    /// building an api request url from given parameters
    public func buildURL(_ endpoint: Endpoint = .weatherFiveDaysThreeHourInterval, coordinate: CLLocationCoordinate2D) throws -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path.append("/data")
        urlComponents.path.append("/\(apiVersion)")

        switch endpoint {
        case .weatherFiveDaysThreeHourInterval:
            urlComponents.path.append("/forecast")
            break
        }

        let appIdQueryString = URLQueryItem(name: "appid", value: "\(self.appId)")

        let coordinateLatQueryString = URLQueryItem(name: "lat", value: "\(coordinate.latitude)")
        let coordinateLonQueryString = URLQueryItem(name: "lon", value: "\(coordinate.longitude)")
        let unitsQuery =
            URLQueryItem(name: "units", value: "\(units)")

        urlComponents.queryItems = [appIdQueryString, coordinateLatQueryString, coordinateLonQueryString, unitsQuery]
        guard let url = urlComponents.url else { throw APIError.invalidURL }
        return url
    }
}
