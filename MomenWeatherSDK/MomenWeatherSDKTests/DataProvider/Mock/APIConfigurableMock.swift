//
//  APIConfigurableMock.swift
//  MomenWeatherSDK
//
//  Created by Momen Shataly on 01.11.20.
//

import Foundation
import CoreLocation
@testable import MomenWeatherSDK

/// used to cofigure and generate the source url for the api.
/// in our mocking case we will only return the resource url.
/// could be adjusted to handle a network resource with query strings.
class APIConfigurableMock: APIConfiguration {

    public override func buildURL(_: Endpoint, coordinate: CLLocationCoordinate2D) throws -> URL {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "response", withExtension: "json") else { throw APIError.invalidURL }
        return url
    }

    required init(host: String = "", appId: String = "", apiVersion: String = "", units: String = "") {
    }
}
