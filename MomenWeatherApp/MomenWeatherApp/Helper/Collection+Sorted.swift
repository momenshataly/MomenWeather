//
//  Collection+Sorted.swift
//  MomenWeatherApp
//
//  Created by Momen Shataly on 06.11.20.
//

import Foundation

extension Collection {

    /**
     * adjusts `sorted(by:)` function signature to be called
     * based on keypaths of containing elements
     * and a comparative operator i.e. `<`, `>` for more human readable sorting.
     */
    func sorted<Value: Comparable>(
        by keyPath: KeyPath<Element, Value>,
        _ comparator: (_ lhs: Value, _ rhs: Value) -> Bool) -> [Element] {
        return self.sorted {
            comparator($0[keyPath: keyPath], $1[keyPath: keyPath])
        }
    }
}

/**
 * `sliced(by:for:)` function signature to be called
 * based on keypaths of containing elements
 * and key Path of a value to group objects by it
 */
public extension Collection {
    func sliced(by dateComponents: Set<Calendar.Component>, for key: KeyPath<Element, TimeInterval>) -> [Date: [Element]] {
        let initial: [Date: [Element]] = [:]
        let groupedByDateComponents = reduce(into: initial) { acc, cur in
            let components = Calendar.current.dateComponents(dateComponents, from: Date(timeIntervalSince1970: cur[keyPath: key]))
            if let date = Calendar.current.date(from: components) {
                let existing = acc[date] ?? []
                acc[date] = existing + [cur]
            }
        }

        return groupedByDateComponents
    }
}
