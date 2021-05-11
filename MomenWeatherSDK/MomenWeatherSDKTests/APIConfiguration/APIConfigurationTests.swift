//
//  APIConfigurationTests.swift
//  MomenWeatherSDKTests
//
//  Created by Momen Shataly on 10.11.20.
//

import XCTest
@testable import MomenWeatherSDK

class APIConfigurationTests: XCTestCase {

    func testApiConfigurationBuildURL_WithDefaultConstructor_ReturnsRightURL() {
        let apiConfig = APIConfiguration(host: "myhost", appId: "myAppId", apiVersion: "3.5", units: "metric")
        do {
            let url = try apiConfig.buildURL(coordinate: .init(latitude: 10, longitude: 10))
            guard let expectedURL = URL(string: "https://myhost/data/3.5/forecast?appid=myAppId&lat=10.0&lon=10.0&units=metric") else { throw APIError.invalidURL }
            XCTAssertEqual(url, expectedURL)
        }catch {
            XCTFail("\(error)")
        }

    }

}
