//
//  APIError.swift
//  MomenWeatherSDK
//
//  Created by Momen Shataly on 01.11.20.
//

import Foundation
import Combine

/// represents an api error to be thrown
public enum APIError: LocalizedError {
    case unknown
    case invalidURL
    case invalidRequest
    case invalidResponse
}

/**
 *  Localizes error with messages
 *  could come in handly when calling HTTP reliant external data sources.
 */
public extension APIError {
    var errorDescription: String? {
        switch self {
        case .unknown:
            return NSLocalizedString("Unkonwn error happend", comment: "")
        case .invalidURL:
            return NSLocalizedString("Couldn't generate valid url", comment: "")
            
        case .invalidRequest:
            return NSLocalizedString("Invalid request is sent", comment: "")
            
        case .invalidResponse:
            return NSLocalizedString("Received invalid response from server", comment: "")
        }
    }
    var failureReason: String? {
        switch self {
        default:
            return NSLocalizedString("", comment: "")
        }
    }
    var recoverySuggestion: String? {
        switch self {
        case .unknown:
            return NSLocalizedString("Try again later", comment: "")
        case .invalidURL:
            return NSLocalizedString("Update the app or switch off any vpn", comment: "")
        case .invalidRequest:
            return NSLocalizedString("Update the app or switch off any vpn", comment: "")
        case .invalidResponse:
            return NSLocalizedString("Update the app", comment: "")
        }
    }
}
