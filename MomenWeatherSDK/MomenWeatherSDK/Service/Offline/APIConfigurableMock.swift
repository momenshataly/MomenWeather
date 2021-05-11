//
//  APIConfigurableMock.swift
//  MomenWeatherSDK
//
//  Created by Momen Shataly on 06.11.20.
//

import Foundation
import CoreLocation

/// used to cofigure and generate the source url for the api.
/// in our mocking case we will only return the resource url.
/// could be adjusted to handle a network resource with query strings.
public class APIConfigurableMock: APIConfigurable {
    public var appId: String = ""
    public var units: String = ""
    public var host: String = "example.com"
    public var apiVersion: String = "v1"

    public func buildURL(_: Endpoint, coordinate: CLLocationCoordinate2D) throws -> URL {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "response", withExtension: "json") else { throw APIError.invalidURL }
        return url
    }

    public init() { }
}
