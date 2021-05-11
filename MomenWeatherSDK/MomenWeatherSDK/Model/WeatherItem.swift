//
//  WeatherItem.swift
//  MomenWeatherSDK
//
//  Created by Momen Shataly on 01.11.20.
//

import Foundation

public struct WeatherItem: Codable {
    // measurement date time
    public let dt: TimeInterval
    // main numeric measurments
    public let main: Dictionary<String, Double>
    // weather condition
    public let weather: [Weather]
    // percentage of clouds
    public let clouds: [String: Int]
    public let wind: [String: Double]
    // visibility in meters
    public let visibility: Int
    // Probability of precipitation
    public let pop: Double
    // part of day n=night, d=day
    //let pod: PartOfDay
    // string representation of date/time
    public let dt_txt: String
}

extension WeatherItem: Hashable {
    public static func ==(lhs: WeatherItem, rhs: WeatherItem) -> Bool {
        lhs.dt == rhs.dt &&
            lhs.main == rhs.main &&
            lhs.weather == rhs.weather &&
            lhs.clouds == rhs.clouds &&
            lhs.wind == rhs.wind &&
            lhs.visibility == rhs.visibility &&
            lhs.pop == rhs.pop &&
            lhs.dt_txt == rhs.dt_txt
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(dt)
        hasher.combine(weather)
        hasher.combine(clouds)
        hasher.combine(wind)
        hasher.combine(visibility)
        hasher.combine(pop)
        hasher.combine(dt_txt)
    }
}
