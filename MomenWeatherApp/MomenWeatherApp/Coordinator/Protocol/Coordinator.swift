//
//  Coordinator.swift
//  MomenWeatherApp
//
//  Created by Momen Shataly on 02.11.20.
//

import Foundation
import UIKit

protocol CoordinatorStep {}

/**
 * used in case we want to dismiss the coordinator, and all it's VCs at anytime
 */
protocol CoordinatorDismissable: AnyObject {
    var childCoordinators: [UUID: Coordinatable] { get set }
    /// we should never call this directly, as this is intended to be used by the `dismissable` property
    func dispose(with identifier: UUID)
}

/**
 * used to enable presentation and coordination of a coordinator VCs
 */
protocol CoordinatorPresentable: AnyObject {
    var identifier: UUID { get }
    var dismissable: CoordinatorDismissable? { get }

    /**
     * used to coordinate to a specific step and perform a ui flow action
     */
    func coordinate(to step: CoordinatorStep)

    /**
     * starts the coordination process by starting the dependencies
     * and probably coordinating to the main step
     */
    func start()
    func finish()
}

protocol Coordinatable: CoordinatorPresentable, CoordinatorDismissable {}

/**
 *  finishing will dispose and dismiss all
 */
extension CoordinatorPresentable {
    func finish() {
        dismissable?.dispose(with: identifier)
    }
}

/**
 *  default implementation for dismissing a coordinator with all it's children
 */
extension CoordinatorDismissable {
    func dispose(with identifier: UUID) {
        let coordinator = childCoordinators[identifier]
        coordinator?.childCoordinators.values.forEach {
            $0.finish()
        }
        childCoordinators[identifier] = nil
    }
}
