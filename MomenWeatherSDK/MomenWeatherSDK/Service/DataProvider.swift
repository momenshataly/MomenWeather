//
//  DataProvider.swift
//  MomenWeatherApp
//
//  Created by Momen Shataly on 06.11.20.
//

import Foundation
import CoreLocation
import OpenCombine
import OpenCombineFoundation

public class DataProvider: NSObject, DataProviding {

    var decoder: JSONDecoder
    var apiConfiguration: APIConfigurable
    private lazy var urlSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 30
        let session = URLSession(configuration: config)
        return session
    }()

    public required init(decoder: JSONDecoder, apiConfiguration: APIConfigurable) {
        self.decoder = decoder
        self.apiConfiguration = apiConfiguration
    }

    public func loadWeather(for coordinate: CLLocationCoordinate2D) throws -> AnyPublisher<WeatherForcastResult, Error> {
        let endpointURL = try apiConfiguration.buildURL(.weatherFiveDaysThreeHourInterval, coordinate: coordinate)

        return loadData(of: endpointURL)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                switch response.statusCode {
                case 200...399:
                    break
                case 404:
                    throw HTTPError.statusCodeError(message: "Not found check url",
                                               code: response.statusCode)
                case 409:
                    throw HTTPError.statusCodeError(
                        message: "Missing authentication or invalid request",
                        code: response.statusCode)
                case 401:
                    throw HTTPError.statusCodeError(
                        message: "Invalid referer, check hash validity",
                        code: response.statusCode)
                case 405:
                    throw HTTPError.statusCodeError(message: "Method not allowed", code: response.statusCode)
                case 403:
                    throw HTTPError.statusCodeError(message: "Forbidden", code: response.statusCode)
                default:
                    throw HTTPError.statusCodeError(
                        message: "Interal server error or unknown error",
                        code: response.statusCode)
                }
                return output.data
            }
            .decode(type: WeatherForcastResult.self, decoder: decoder)
            .eraseToAnyPublisher()
    }

    func loadData(of url: URL) -> URLSession.OCombine.DataTaskPublisher {
        urlSession.ocombine.dataTaskPublisher(for: url)
    }
}
