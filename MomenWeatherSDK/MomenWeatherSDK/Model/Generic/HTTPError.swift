//
//  HTTPError.swift
//  MomenWeatherSDK
//
//  Created by Momen Shataly on 01.11.20.
//

import Foundation

/// represents a http status code error to be thrown
public enum HTTPError: LocalizedError {
    case statusCodeError(message: String, code: Int)
}

/**
 *  Localizes error with messages
 *  could come in handly when calling HTTP reliant external data sources.
 */
public extension HTTPError {
    var errorDescription: String? {
        switch self {
        case .statusCodeError(let message, let code):
        return NSLocalizedString("HTTP code error \(code):\n\(message)", comment: "")
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
        case .statusCodeError( _, _):
        return NSLocalizedString("Check your connectio or try again later", comment: "")
        }
    }
}
