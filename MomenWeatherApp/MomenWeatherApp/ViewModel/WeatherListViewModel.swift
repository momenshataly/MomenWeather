//
//  WeatherListViewModel.swift
//  MomenWeatherApp
//
//  Created by Momen Shataly on 02.11.20.
//

import Foundation
import MomenWeatherSDK
import CoreLocation


public final class WeatherListViewModel: Hashable {

    @Published var weatherList: [WeatherDayViewModel]
    @Published var city: City?
    @Published var date: Date
    @Published var location: CLLocationCoordinate2D
    @Published var isOnline: Bool


    init(weatherList: [WeatherDayViewModel] = [],
         date: Date = Date(),
         city: City? = nil,
         isOnline: Bool = true,
         location: CLLocationCoordinate2D = .init(latitude: 0.0, longitude: 0.0)) {
        self.weatherList = weatherList
        self.date = date
        self.city = city
        self.isOnline = isOnline
        self.location = location
    }

    public static func == (lhs: WeatherListViewModel, rhs: WeatherListViewModel) -> Bool {
        return (lhs.weatherList == rhs.weatherList &&
                    lhs.location == rhs.location &&
                    lhs.date == rhs.date)
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(weatherList)
        hasher.combine(location)
        hasher.combine(date)
    }
}

extension CLLocationCoordinate2D: Hashable {

    public static func==(lhs: Self, rhs: Self) -> Bool {
        lhs.latitude == rhs.longitude &&
            lhs.longitude == rhs.latitude
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(longitude)
        hasher.combine(latitude)
    }
}

extension WeatherListViewModel {
    func weatherListByDay(date: Date) -> WeatherDayViewModel? {
        weatherList.first(where: { $0.date == date })
    }
}
