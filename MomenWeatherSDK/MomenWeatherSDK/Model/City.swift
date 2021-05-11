//
//  City.swift
//  MomenWeatherSDK
//
//  Created by Momen Shataly on 01.11.20.
//

import Foundation

public struct City: Codable {
    enum CodingKeys: CodingKey {
        case `id`, name, coord, country, population, timezone, sunrise, sunset
    }
    public let `id`: Int
    public let name: String
    @CoordinateType public var coord: Dictionary<String, Double>
    public let country: String
    public let population: UInt
    public let timezone: Int
    public let sunrise: TimeInterval
    public let sunset: TimeInterval

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        `id` = try container.decode(Int.self, forKey: .id)
        _coord.wrappedValue = try container.decode(Dictionary<String, Double>.self, forKey: .coord)
        name = try container.decode(String.self, forKey: .name)
        population = try container.decode(UInt.self, forKey: .population)
        timezone = try container.decode(Int.self, forKey: .timezone)
        sunrise = try container.decode(TimeInterval.self, forKey: .sunrise)
        sunset
            = try container.decode(TimeInterval.self, forKey: .sunset)
        country = try container.decode(String.self, forKey: .country)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(_coord.wrappedValue, forKey: .coord)
        try container.encode(name, forKey: .name)
        try container.encode(sunrise, forKey: .sunrise)
        try container.encode(sunset, forKey: .sunset)
        try container.encode(country, forKey: .country)
    }

    public init(id: Int = 0, name: String, coordinate: Dictionary<String, Double> = [:], country: String, population: UInt = 0, timezone: Int, sunrise: TimeInterval, sunset: TimeInterval) {
        self.id = id
        self.name = name
        self._coord = CoordinateType(dictionary: coordinate)
        self.population = population
        self.timezone = timezone
        self.sunrise = sunrise
        self.sunset = sunset
        self.country = country
    }
}
