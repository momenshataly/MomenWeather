//
//  Collection+HumanReadableSort.swift
//  MomenWeatherSDK
//
//  Created by Momen Shataly on 06.11.20.
//

import Foundation

public extension Collection {

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
