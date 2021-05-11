//
//  Date+TimeDateFormatter.swift
//  MomenWeatherApp
//
//  Created by Momen Shataly on 06.11.20.
//

import Foundation
public extension Date {
    var timeHourString: String {
        let calendar = Calendar.current
        let component = calendar.dateComponents([.hour], from: self)
        return String(format: "%dUHR", component.hour ?? 0)
    }

    var dateString: String {
        let dateFormatter: DateFormatter = {
            let dt = DateFormatter()
            dt.timeStyle = .none
            dt.dateStyle = .medium
            return dt
        }()
        return dateFormatter.string(from: self)
    }
}
