//
//  ReachabilityService.swift
//  MomenWeatherSDK
//
//  Created by Momen Shataly on 06.11.20.
//

import Foundation
import SystemConfiguration
import Network
import OpenCombine


public enum ReachabilityError: Error {
    case deviceIsNotConnected
}

extension ReachabilityError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .deviceIsNotConnected:
            return NSLocalizedString("Couldn't connect to internet", comment: "")
        }
    }
    public var failureReason: String? {
        switch self {
        default:
            return NSLocalizedString("Internet connection failure", comment: "")
        }
    }
    public var recoverySuggestion: String? {
        switch self {
        case .deviceIsNotConnected:
            return NSLocalizedString("Check your WiFi or Data plan and try again later", comment: "")
        }
    }
}

/**
 * class that monitors and provides a publisher to determine internet reachability
 */
public class Reachability: ReachabilityProviding {
    
    internal var isConnectedToNetworkPublisher: PassthroughSubject<Bool, Never> = PassthroughSubject<Bool, Never>()
    public var isConnectedToNetwork: AnyPublisher<Bool, Never>
    private let monitor = NWPathMonitor()
    private let dispatchQueue = DispatchQueue(label: "com.momenWeatherSDK.reachability")
    
    public init() {
        isConnectedToNetwork = isConnectedToNetworkPublisher.eraseToAnyPublisher()
        self.monitor.pathUpdateHandler =  { [weak self] path in
            switch path.status {
            case .satisfied:
                self?.isConnectedToNetworkPublisher.send(true)
            default:
                self?.isConnectedToNetworkPublisher.send(false)
            }
        }
        self.monitor.start(queue: dispatchQueue)
    }
}
