//
//  DataProviderTests.swift
//  MomenWeatherSDKTests
//
//  Created by Momen Shataly on 10.11.20.
//

import XCTest
import Combine
@testable import MomenWeatherSDK

class DataProviderTests: XCTestCase {

    func testDataProviderMockLoadWeather_WithMockJSON_LoadsRightCountOfWeather() throws {

        let expectation = XCTestExpectation(description: "loading weather data")
        var cancellable = Set<AnyCancellable>()
        let dataProvider = DataProviderMock(decoder: JSONDecoder(), apiConfiguration: APIConfigurableMock())
        try dataProvider.loadWeather(for: .init(latitude: 50.937531, longitude: 6.960279)).sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                XCTFail("\(error)")
            case .finished:
                expectation.fulfill()
            }
        }, receiveValue: { weatherResult in
            XCTAssert(weatherResult.list.count > 0)
        }).store(in: &cancellable)
        wait(for: [expectation], timeout: 10)
    }

}
