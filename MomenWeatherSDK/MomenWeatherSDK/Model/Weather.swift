//
//  Weather.swift
//  MomenWeatherSDK
//
//  Created by Momen Shataly on 01.11.20.
//

import Foundation

public struct Weather: Codable {
    enum CodingKeys: CodingKey {
        case id, main, description, icon
    }
    public let `id`: Int
    public let main: String
    public let `description`: String
    @WeatherIconType public var icon: String

    public init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        main = try container.decode(String.self, forKey: .main)
        description = try container.decode(String.self, forKey: .description)
        _icon = WeatherIconType(urlString: try container.decode(String.self, forKey: .icon))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(main, forKey: .main)
        try container.encode(description, forKey: .description)
        try container.encode(_icon.wrappedValue, forKey: .icon)
    }
}

extension Weather: Hashable {
    public static func == (lhs: Weather, rhs: Weather) -> Bool {
        lhs.id == rhs.id &&
            lhs.main == rhs.main &&
            lhs.description == rhs.description &&
            lhs.icon == rhs.icon
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(main)
        hasher.combine(description)
        hasher.combine(icon)
    }
}
