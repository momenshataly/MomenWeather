//
//  WeatherIconTypeTests.swift
//  MomenWeatherSDKTests
//
//  Created by Momen Shataly on 10.11.20.
//

import XCTest
@testable import MomenWeatherSDK
class WeatherIconTypeTests: XCTestCase {

    func testWeatherIconType_Initaliser_CorrectlyInitialises_WithValidValues() {
        let weatherIcon = WeatherIconType(urlString: "iconName")
        XCTAssertEqual(weatherIcon.iconImageUrl, URL(string: "http://openweathermap.org/img/wn/iconName@2x.png"))
        XCTAssertEqual(weatherIcon.wrappedValue, "http://openweathermap.org/img/wn/iconName@2x.png")
    }

    func testWeatherIconType_Initaliser_Nullifies_WithInvalidValues() {
        let weatherIcon = WeatherIconType(urlString: "icon Name")
        XCTAssertNil(weatherIcon.iconImageUrl)
        XCTAssertEqual(weatherIcon.wrappedValue, "")
        XCTAssertEqual(weatherIcon.projectedValue, WeatherIconType(urlString: "icon Name"))
    }
}
