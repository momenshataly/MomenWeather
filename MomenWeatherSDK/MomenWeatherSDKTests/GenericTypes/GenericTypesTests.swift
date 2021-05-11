//
//  GenericTypesTests.swift
//  MomenWeatherSDKTests
//
//  Created by Momen Shataly on 10.11.20.
//

import XCTest
import CoreLocation
@testable import MomenWeatherSDK

class GenericTypesTests: XCTestCase {


    func testCoordinateType_InitialisesCorrectly_WithValidValues() {
        let dictionaryToTest: [String: Double] = ["lat": 12.345, "lon": 67.890]
        let coordinate = CoordinateType(dictionary: dictionaryToTest)
        XCTAssertEqual(coordinate.coordinate.latitude, CLLocationDegrees(12.345))
        XCTAssertEqual(coordinate.coordinate.longitude, CLLocationDegrees(67.890))
    }

    func testCoordinateType_InitialiserThrowsError_WithInValidValues() {
        let dictionaryToTest: [String: Double] = ["lataaa": 12.345, "lonaa": 67.890]
        let coordinate = CoordinateType(dictionary: dictionaryToTest)
        XCTAssertEqual(coordinate.coordinate.latitude, CLLocationDegrees(0))
        XCTAssertEqual(coordinate.coordinate.longitude, CLLocationDegrees(0))
    }


}
