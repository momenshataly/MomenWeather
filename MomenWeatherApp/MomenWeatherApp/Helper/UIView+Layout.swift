//
//  UIView+Layout.swift
//  MomenWeatherApp
//
//  Created by Momen Shataly on 06.11.20.
//

import Foundation
import UIKit

public extension UIView {

    /// Pins the receiver's edges to the edges of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter layoutElement: the layout element to pin to
    /// - Parameter offset: the offset from the edges
    /// - Returns: The active constraints
    @discardableResult func pinEdges(to layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> [NSLayoutConstraint] {
        disableConstraintTranslation()
        return [
            pinTopEdge(to: layoutElement, withOffset: offset),
            pinBottomEdge(to: layoutElement, withOffset: -offset),
            pinLeadingEdge(to: layoutElement, withOffset: offset),
            pinTrailingEdge(to: layoutElement, withOffset: -offset)
        ]
    }

    /// Pins the receiver's leading and trailing edge to the corresponding edges of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter layoutElement: the layout element to pin to
    /// - Parameter offset: the offset from the edge
    /// - Returns: The active constraints
    @discardableResult func pinLeadingAndTrailingEdges(to layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> [NSLayoutConstraint] {
        disableConstraintTranslation()
        return [
            pinLeadingEdge(to: layoutElement, withOffset: offset),
            pinTrailingEdge(to: layoutElement, withOffset: -offset)
        ]
    }

    /// Pins the receiver's leading edge to the corresponding edge of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter layoutElement: the layout element to pin to
    /// - Parameter offset: the offset from the edge
    /// - Returns: The active constraint
    @discardableResult func pinLeadingEdge(to layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return leadingAnchor.constraint(equalTo: layoutElement.leadingAnchor, constant: offset).activate()
    }

    /// Pins the receiver's leading edge with an equal or less offset to the corresponding edge of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter layoutElement: the layout element to pin to
    /// - Parameter offset: the offset from the edge
    /// - Returns: The active constraint
    @discardableResult func pinLeadingEdge(lessThanOrEqualTo layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return leadingAnchor.constraint(lessThanOrEqualTo: layoutElement.leadingAnchor, constant: offset).activate()
    }

    /// Pins the receiver's leading edge with an equal or greater offset to the corresponding edge of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter layoutElement: the layout element to pin to
    /// - Parameter offset: the offset from the edge
    /// - Returns: The active constraint
    @discardableResult func pinLeadingEdge(greaterThanOrEqualTo layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return leadingAnchor.constraint(greaterThanOrEqualTo: layoutElement.leadingAnchor, constant: offset).activate()
    }

    /// Pins the receiver's leading edge to the trailing edge of the passed layout element.
    ///
    /// - Parameter layoutElement: the layout element to pin to
    /// - Parameter offset: the offset from the edge
    /// - Returns: The active constraint
    @discardableResult func pinLeadingEdgeToTrailingEdge(of layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        leadingAnchor.constraint(equalTo: layoutElement.trailingAnchor, constant: offset).activate()
    }

    /// Pins the receiver's leading edge less than or equal to the trailing edge of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter layoutElement: the layout element to pin to
    /// - Parameter offset: the offset from the edge
    /// - Returns: The active constraint
    @discardableResult func pinLeadingEdgeToTrailingEdge(lessThanOrEqualTo layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return leadingAnchor.constraint(lessThanOrEqualTo: layoutElement.trailingAnchor, constant: offset).activate()
    }

    /// Pins the receiver's leading edge greater than or equal to the trailing edge of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter layoutElement: the layout element to pin to
    /// - Parameter offset: the offset from the edge
    /// - Returns: The active constraint
    @discardableResult func pinLeadingEdgeToTrailingEdge(greaterThanOrEqualTo layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return leadingAnchor.constraint(greaterThanOrEqualTo: layoutElement.trailingAnchor, constant: offset).activate()
    }

    /// Pins the receiver's trailing edge to the corresponding edge of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter layoutElement: the layout element to pin to
    /// - Parameter offset: the offset from the edge
    @discardableResult func pinTrailingEdge(to layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return trailingAnchor.constraint(equalTo: layoutElement.trailingAnchor, constant: offset).activate()
    }

    /// Pins the receiver's trailing edge less than or equal to the trailing edge of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter layoutElement: the layout element to pin to
    /// - Parameter offset: the offset from the edge
    /// - Returns: The active constraint
    @discardableResult func pinTrailingEdge(lessThanOrEqualTo layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return trailingAnchor.constraint(lessThanOrEqualTo: layoutElement.trailingAnchor, constant: offset).activate()
    }

    /// Pins the receiver's trailing edge greater than or equal to the trailing edge of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter layoutElement: the layout element to pin to
    /// - Parameter offset: the offset from the edge
    /// - Returns: The active constraint
    @discardableResult func pinTrailingEdge(greaterThanOrEqualTo layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return trailingAnchor.constraint(greaterThanOrEqualTo: layoutElement.trailingAnchor, constant: offset).activate()
    }

    /// Pins the receiver's trailing edge to the leading edge of the passed layout element
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameters:
    ///   - layoutElement: the layout element to pin to
    ///   - offset: the offset from the edge
    /// - Returns: The active constraint
    @discardableResult func pinTrailingEdgeToLeading(of layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return trailingAnchor.constraint(equalTo: layoutElement.leadingAnchor, constant: offset).activate()
    }

    /// Pins the receiver's trailing edge less than or equal to the leading edge of the passed layout element
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter layoutElement: the layout element to pin to
    /// - Parameter offset: the offset from the edge
    /// - Returns: The active constraint
    @discardableResult func pinTrailingEdgeToLeading(lessThanOrEqualTo layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return trailingAnchor.constraint(lessThanOrEqualTo: layoutElement.leadingAnchor, constant: offset).activate()
    }

    /// Pins the receiver's trailing edge greater than or equal to the leading edge of the passed layout element
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter layoutElement: the layout element to pin to
    /// - Parameter offset: the offset from the edge
    /// - Returns: The active constraint
    @discardableResult func pinTrailingEdgeToLeading(greaterThanOrEqualTo layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return trailingAnchor.constraint(greaterThanOrEqualTo: layoutElement.leadingAnchor, constant: offset).activate()
    }

    /// Pins the receiver's top edge to the corresponding edge of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameters:
    ///   - layoutElement: the layout element to pin to
    ///   - offset: the offset from the edge
    /// - Returns: The active constraint
    @discardableResult func pinTopEdge(to layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return topAnchor.constraint(equalTo: layoutElement.topAnchor, constant: offset).activate()
    }

    /// Pins the receiver's top edge less than or equal to the top edge of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter layoutElement: the layout element to pin to
    /// - Parameter offset: the offset from the edge
    /// - Returns: The active constraint
    @discardableResult func pinTopEdge(lessThanOrEqualTo layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return topAnchor.constraint(lessThanOrEqualTo: layoutElement.topAnchor, constant: offset).activate()
    }

    /// Pins the receiver's top edge greater than or equal to the top edge of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter layoutElement: the layout element to pin to
    /// - Parameter offset: the offset from the edge
    /// - Returns: The active constraint
    @discardableResult func pinTopEdge(greaterThanOrEqualTo layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return topAnchor.constraint(greaterThanOrEqualTo: layoutElement.topAnchor, constant: offset).activate()
    }

    /// Pins the receiver's bottom edge to the corresponding edge of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameters:
    ///   - layoutElement: the layout element to pin to
    ///   - offset: the offset from the edge
    /// - Returns: The active constraint
    @discardableResult func pinBottomEdge(to layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return bottomAnchor.constraint(equalTo: layoutElement.bottomAnchor, constant: offset).activate()
    }

    /// Pins the receiver's bottom edge less than or equal to the bottom edge of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter layoutElement: the layout element to pin to
    /// - Parameter offset: the offset from the edge
    /// - Returns: The active constraint
    @discardableResult func pinBottomEdge(lessThanOrEqualTo layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return bottomAnchor.constraint(lessThanOrEqualTo: layoutElement.bottomAnchor, constant: offset).activate()
    }

    /// Pins the receiver's bottom edge greater than or equal to the bottom edge of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter layoutElement: the layout element to pin to
    /// - Parameter offset: the offset from the edge
    /// - Returns: The active constraint
    @discardableResult func pinBottomEdge(greaterThanOrEqualTo layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return bottomAnchor.constraint(greaterThanOrEqualTo: layoutElement.bottomAnchor, constant: offset).activate()
    }

    /// Pins the receiver's top and bottom edge to the corresponding edges of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameters:
    ///   - layoutElement: the layout element to pin to
    ///   - offset: the offset from the edge
    /// - Returns: The active constraints
    @discardableResult func pinTopAndBottomEdge(to layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> [NSLayoutConstraint] {
        disableConstraintTranslation()
        return [
            pinTopEdge(to: layoutElement, withOffset: offset),
            pinBottomEdge(to: layoutElement, withOffset: -offset)
        ]
    }

    /// Pins the receiver's top edge to the bottom edge of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameters:
    ///   - layoutElement: the layout element to pin to
    ///   - offset: the offset from the edge
    /// - Returns: The active constraint
    @discardableResult func pinTopEdgeToBottom(of layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return topAnchor.constraint(equalTo: layoutElement.bottomAnchor, constant: offset).activate()
    }

    /// Pins the receiver's top edge to the center of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameters:
    ///   - layoutElement: the layout element to pin to
    ///   - offset: the offset from the edge
    /// - Returns: The active constraint
    @discardableResult func pinTopEdgeToCenter(of layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return topAnchor.constraint(equalTo: layoutElement.centerYAnchor, constant: offset).activate()
    }

    /// Pins the receiver's top edge to the bottom edge of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameters:
    ///   - layoutElement: the layout element to pin to
    ///   - offset: the offset from the edge
    /// - Returns: The active constraint
    @discardableResult func pinBottomEdgeToTop(of layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return bottomAnchor.constraint(equalTo: layoutElement.topAnchor, constant: offset).activate()
    }

    /// Aligns the receiver's horizontal center to the one of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter layoutElement: the view to center to
    /// - Returns: The active constraint
    @discardableResult func centerHorizontally(to layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return centerXAnchor.constraint(equalTo: layoutElement.centerXAnchor, constant: offset).activate()
    }

    /// Aligns the receiver's vertical center to the one of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter layoutElement: the layout element to center to
    /// - Returns: The active constraint
    @discardableResult func centerVertically(to layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return centerYAnchor.constraint(equalTo: layoutElement.centerYAnchor, constant: offset).activate()
    }

    /// Aligns the receiver' s horizontal and vertical center to the center of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter layoutElement: the layout element to center to
    /// - Returns: The active constraints
    @discardableResult func center(to layoutElement: LayoutElement) -> [NSLayoutConstraint] {
        disableConstraintTranslation()
        return [
            centerVertically(to: layoutElement),
            centerHorizontally(to: layoutElement)
        ]
    }

    /// Adds a aspect ratio constraint to the receiver.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter aspectRatio: The aspect ratio to apply. The ratio is defined as height/width.
    /// - Returns: The active constraint
    @discardableResult func addAspectRatioConstraint(with aspectRatio: CGFloat) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return heightAnchor.constraint(equalTo: widthAnchor, multiplier: aspectRatio).activate()
    }

    /// Sets the receiver's size to the passed size
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter size: The size to pin to
    /// - Returns: The active constraints
    @discardableResult func pinSize(to size: CGSize) -> [NSLayoutConstraint] {
        disableConstraintTranslation()
        return [
            pinWidth(to: size.width).activate(),
            pinHeight(to: size.height).activate()
        ]
    }

    /// Sets the receiver's size to the size of the passed layout element
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter layoutGuide: The layout guide to pin to
    /// - Returns: The active constraints
    @discardableResult func pinSize(to layoutElement: LayoutElement) -> [NSLayoutConstraint] {
        disableConstraintTranslation()
        return [
            widthAnchor.constraint(equalTo: layoutElement.widthAnchor).activate(),
            heightAnchor.constraint(equalTo: layoutElement.heightAnchor).activate()
        ]
    }

    /// Sets the receiver's height to the passed height
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter height: The height to pin to
    /// - Returns: The active constraint
    @discardableResult func pinHeight(to height: CGFloat) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return heightAnchor.constraint(equalToConstant: height).activate()
    }

    /// Sets the receiver's height greater than or equal to the passed height
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter height: The height to pin to
    /// - Returns: The active constraint
    @discardableResult func pinHeight(greaterThanOrEqualTo height: CGFloat) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return heightAnchor.constraint(greaterThanOrEqualToConstant: height).activate()
    }

    /// Sets the receiver's height less than or equal to the passed height
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter height: The height to pin to
    /// - Returns: The active constraint
    @discardableResult func pinHeight(lessThanOrEqualTo height: CGFloat) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return heightAnchor.constraint(lessThanOrEqualToConstant: height).activate()
    }

    /// Sets the receiver's width to the passed width
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter width: The width to pin to
    /// - Returns: The active constraint
    @discardableResult func pinWidth(to width: CGFloat) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return widthAnchor.constraint(equalToConstant: width).activate()
    }

    /// Sets the receiver's width greater than or equal to the passed height
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter height: The height to pin to
    /// - Returns: The active constraint
    @discardableResult func pinWidth(greaterThanOrEqualTo width: CGFloat) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return widthAnchor.constraint(greaterThanOrEqualToConstant: width).activate()
    }

    /// Sets the receiver's height less than or equal to the passed height
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter height: The height to pin to
    /// - Returns: The active constraint
    @discardableResult func pinWidth(lessThanOrEqualTo width: CGFloat) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return widthAnchor.constraint(lessThanOrEqualToConstant: width).activate()
    }

    /// Sets the receiver's width and height to the passed value
    ///
    /// - Parameter size: The width and height value to pin to
    /// - Returns: The active constraints
    @discardableResult func pinWidthAndHeight(to size: CGFloat) -> [NSLayoutConstraint] {
        disableConstraintTranslation()
        return [heightAnchor.constraint(equalToConstant: size).activate(),
                widthAnchor.constraint(equalToConstant: size).activate()]
    }

    /// Pins the width of the receiver to the width of the passed layout element mulitplied by a factor.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameters:
    ///   - layoutElement: the layout element to pin to
    ///   - multiplier: The factor that the width of `layoutElement` should be multiplied by
    /// - Returns: The active constraint
    @discardableResult func pinWidth(to layoutElement: LayoutElement, multipliedBy multiplier: CGFloat = 1.0, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return widthAnchor.constraint(equalTo: layoutElement.widthAnchor, multiplier: multiplier, constant: offset).activate()
    }

    /// Pins the height of the receiver to the height of the passed layout element mulitplied by a factor.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameters:
    ///   - layoutElement: the layout element to pin to
    ///   - multiplier: The factor that the height of `layoutElement` should be multiplied by
    /// - Returns: The active constraint
    @discardableResult func pinHeight(to layoutElement: LayoutElement, multipliedBy multiplier: CGFloat = 1.0, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return heightAnchor.constraint(equalTo: layoutElement.heightAnchor, multiplier: multiplier, constant: offset).activate()
    }

    /// Pins the width of the receiver less than or equal to the width of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameters:
    ///   - layoutElement: the layout element to pin to
    ///   - offset: The constant to add to the constraint
    /// - Returns: The active constraint
    @discardableResult func pinWidth(lessThanOrEqualTo layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return widthAnchor.constraint(lessThanOrEqualTo: layoutElement.widthAnchor, constant: offset).activate()
    }

    /// Pins the width of the receiver greater than or equal to the width of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameters:
    ///   - layoutElement: the layout element to pin to
    ///   - offset: The constant to add to the constraint
    /// - Returns: The active constraint
    @discardableResult func pinWidth(greaterThanOrEqualTo layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return widthAnchor.constraint(greaterThanOrEqualTo: layoutElement.widthAnchor, constant: offset).activate()
    }

    /// Pins the height of the receiver less than or equal to the height of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameters:
    ///   - layoutElement: the layout element to pin to
    ///   - offset: The constant to add to the constraint
    /// - Returns: The active constraint
    @discardableResult func pinHeight(lessThanOrEqualTo layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return heightAnchor.constraint(lessThanOrEqualTo: layoutElement.heightAnchor, constant: offset).activate()
    }

    /// Pins the height of the receiver greater than or equal to the height of the passed layout element.
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameters:
    ///   - layoutElement: the layout element to pin to
    ///   - offset: The constant to add to the constraint
    /// - Returns: The active constraint
    @discardableResult func pinHeight(greaterThanOrEqualTo layoutElement: LayoutElement, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return heightAnchor.constraint(greaterThanOrEqualTo: layoutElement.heightAnchor, constant: offset).activate()
    }

    /// Sets the vertical content hugging priority
    ///
    /// - Parameters:
    ///   - priority: optional priority to set to. Defaults to .defaultLow
    ///   - offset: an optional offset. Negative values mean that the View should grow. Defaults to 0
    func setVerticalContentHugging(to priority: UILayoutPriority = .defaultLow, withOffset offset: Float = 0) {
        disableConstraintTranslation()
        setContentHuggingPriority(UILayoutPriority(priority.rawValue + offset), for: .vertical)
    }

    /// Sets the horizontal content hugging priority
    ///
    /// - Parameters:
    ///   - priority: optional priority to set to. Defaults to .defaultLow
    ///   - offset: an optional offset. Negative values mean that the View should grow. Defaults to 0
    func setHorizontalContentHugging(to priority: UILayoutPriority = .defaultLow, withOffset offset: Float = 0) {
        disableConstraintTranslation()
        setContentHuggingPriority(UILayoutPriority(priority.rawValue + offset), for: .horizontal)
    }

    /// Pins the receiver's width and height proportionally to aspectRatio factor
    /// Disables `translatesAutoresizingMaskIntoConstraints` when called
    ///
    /// - Parameter aspectRatio: aspect ratio between width and height
    /// - Returns: The active constraint
    @discardableResult func pinAspectRatio(to aspectRatio: CGFloat) -> NSLayoutConstraint {
        disableConstraintTranslation()
        return widthAnchor.constraint(equalTo: heightAnchor, multiplier: aspectRatio).activate()
    }

    // MARK: - Helpers

    private func disableConstraintTranslation() {
        guard translatesAutoresizingMaskIntoConstraints else { return }
        translatesAutoresizingMaskIntoConstraints = false
    }
}

public protocol LayoutElement {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension UIView: LayoutElement {}

extension UILayoutGuide: LayoutElement {}

public extension NSLayoutConstraint {

    /// Activates the receiver and returns it.
    @discardableResult func activate() -> NSLayoutConstraint {
        if !isActive {
            isActive = true
        }

        return self
    }

    /// Deactivate the receiver and returns it.
    @discardableResult func deactivate() -> NSLayoutConstraint {
        isActive = false
        return self
    }
}
