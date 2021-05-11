//
//  With.swift
//  MomenWeatherApp
//
//  Created by Momen Shataly on 06.11.20.
//

import CoreGraphics
import Foundation
import UIKit.UIGeometry

public protocol With {}

extension With where Self: Any {

    /// Makes it available to set properties with closures just after initializing and copying the value types.
    ///
    ///     let frame = CGRect().with {
    ///       $0.origin.x = 10
    ///       $0.size.width = 100
    ///     }
    public func with(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }

    /// Makes it available to execute something with closures.
    ///
    ///     UserDefaults.standard.do {
    ///       $0.set("devxoul", forKey: "username")
    ///       $0.set("devxoul@gmail.com", forKey: "email")
    ///       $0.synchronize()
    ///     }
    public func `do`(_ block: (Self) throws -> Void) rethrows {
        try block(self)
    }
}

extension NSObject: With {}

extension CGPoint: With {}
extension CGRect: With {}
extension CGSize: With {}
extension CGVector: With {}

extension UIEdgeInsets: With {}
extension UIOffset: With {}
extension UIRectEdge: With {}
