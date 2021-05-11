//
//  CityTypeTests.swift
//  MomenWeatherSDKTests
//
//  Created by Momen Shataly on 10.11.20.
//

import XCTest
@testable import MomenWeatherSDK

class CityTypeTests: XCTestCase {
    func testCity_Initaliser_CorrectlyInitialises_WithValidValues() {
        let city = City(id: 1, name: "city name", coordinate: ["lat": 10.0, "lon": 10.0], country: "PO", population: 324, timezone: 2, sunrise: 23156469, sunset: 789462)

        XCTAssertEqual(city.id, 1)
        XCTAssertEqual(city.name, "city name")
        XCTAssertEqual(city.$coord, CoordinateType(dictionary: ["lat": 10.0, "lon": 10.0]))
        XCTAssertEqual(city.country, "PO")
        XCTAssertEqual(city.population, 324)
        XCTAssertEqual(city.timezone, 2)
        XCTAssertEqual(city.sunrise, 23156469)
        XCTAssertEqual(city.sunset, 789462)

    }
}
