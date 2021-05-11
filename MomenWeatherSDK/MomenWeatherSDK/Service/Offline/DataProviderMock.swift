//
//  DataProviderMock.swift
//  MomenWeatherSDK
//
//  Created by Momen Shataly on 02.11.20.
//

import Foundation
import OpenCombine
import CoreLocation

public class DataProviderMock: DataProvider {
    public override func loadWeather(for coordinate: CLLocationCoordinate2D) throws -> AnyPublisher<WeatherForcastResult, Error> {
        let endpointURL = try apiConfiguration.buildURL(.weatherFiveDaysThreeHourInterval, coordinate: coordinate)

        return loadData(of: endpointURL)
            .tryMap { output in
                return output.data
            }
            .decode(type: WeatherForcastResult.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
