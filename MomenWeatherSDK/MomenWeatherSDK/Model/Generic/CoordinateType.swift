//
//  CoordinateType.swift
//  MomenWeatherSDK
//
//  Created by Momen Shataly on 01.11.20.
//

import Foundation
import CoreLocation

/**
 *  A `@propertyWrapper` and a generic type to wrap around a coordinate,
 *  in order to elicitate the right values from the given json dictionary.
 */
@propertyWrapper public struct CoordinateType {
    
    public var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    public var projectedValue: CoordinateType { return self }
    
    public var wrappedValue: Dictionary<String, Double> {
        
        get { return ["lat": coordinate.latitude, "lon": coordinate.longitude]}
        set {
            guard let latitude = newValue["lat"] else { return }
            guard let longitude = newValue["lon"] else { return }
            coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    }
    
    public init(dictionary: Dictionary<String, Double> = [:]) {
        wrappedValue = dictionary
    }
}

extension CoordinateType: Equatable {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.coordinate.latitude == rhs.coordinate.latitude &&
            lhs.coordinate.longitude == rhs.coordinate.longitude
    }
}
