//
//  WeatherIconType.swift
//  MomenWeatherSDK
//
//  Created by Momen Shataly on 01.11.20.
//

import Foundation

@propertyWrapper public struct WeatherIconType {
    public var iconImageUrl: URL?
    public var projectedValue: WeatherIconType { return self }
    public var wrappedValue: String {
        get {
            iconImageUrl?.absoluteString ?? ""
        }

        set {
            let stringFormat = "http://openweathermap.org/img/wn/%@@2x.png"
            let iconImageUrlString = String(format: stringFormat, newValue)
            iconImageUrl = URL(string: iconImageUrlString)
        }
    }

    init(urlString: String) {
        self.wrappedValue = urlString
    }
}

extension WeatherIconType: Equatable {
    public static func ==(lhs: WeatherIconType, rhs: WeatherIconType) -> Bool {
        lhs.iconImageUrl == rhs.iconImageUrl &&
            lhs.wrappedValue == rhs.wrappedValue
    }
}
