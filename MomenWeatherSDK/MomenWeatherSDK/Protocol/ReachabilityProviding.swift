//
//  ReachabilityProviding.swift
//  MomenWeatherSDK
//
//  Created by Momen Shataly on 01.11.20.
//

import Foundation
import OpenCombine

public protocol ReachabilityProviding {
    var isConnectedToNetwork: AnyPublisher<Bool, Never> { get }
}
