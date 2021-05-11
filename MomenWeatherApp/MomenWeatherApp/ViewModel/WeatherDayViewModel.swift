//
//  WeatherDayViewModel.swift
//  MomenWeatherApp
//
//  Created by Momen Shataly on 06.11.20.
//

import Foundation
import MomenWeatherSDK
import Combine

class WeatherDayViewModel: Hashable {

    @Published var weatherList: [WeatherItem]
    @Published var date: Date

    init(date: Date = Date(), weatherList: [WeatherItem] = [] ) {
        self.weatherList = weatherList
        self.date = date
    }

    static func == (lhs: WeatherDayViewModel, rhs: WeatherDayViewModel) -> Bool {
        lhs.weatherList == rhs.weatherList &&
            lhs.date == rhs.date
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(weatherList)
        hasher.combine(date)
    }
}
