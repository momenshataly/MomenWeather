//
//  WeatherForcastResult.swift
//  MomenWeatherSDK
//
//  Created by Momen Shataly on 01.11.20.
//

import Foundation

public struct WeatherForcastResult: Codable {
    // response http code
    public let cod: String
    // message in case of any
    public let message: Int
    // count of list items
    public let cnt: Int
    // list of weather items
    public let list: [WeatherItem]
    // city information
    public let city: City
}
