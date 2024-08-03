//
//  Computation.swift
//  Vertanom
//
//  Created by Tristan Listanco on 7/25/24.
//

import Foundation

enum Computations {
    static func averageValue(for data: [SensorValue]) -> Double {
        let total = data.reduce(0) { $0 + $1.value }
        return data.isEmpty ? 0 : Double(total) / Double(data.count)
    }

    static func latestValue(for data: [SensorValue]) -> Double {
        data.last?.value ?? 0
    }

    static func dailyAverage(for data: [SensorValue]) -> Double {
        let days = Set(data.map { Calendar.current.component(.weekday, from: $0.date) })
        let total = data.reduce(0) { $0 + $1.value }
        return days.isEmpty ? 0 : Double(total) / Double(days.count)
    }

    static func weekdayAverage(for data: [SensorValue]) -> Double {
        let weekdays = data.filter { !Calendar.current.isDateInWeekend($0.date) }
        let total = weekdays.reduce(0) { $0 + $1.value }
        return weekdays.isEmpty ? 0 : Double(total) / Double(weekdays.count)
    }

    static func weekendAverage(for data: [SensorValue]) -> Double {
        let weekends = data.filter { Calendar.current.isDateInWeekend($0.date) }
        let total = weekends.reduce(0) { $0 + $1.value }
        return weekends.isEmpty ? 0 : Double(total) / Double(weekends.count)
    }

    static func highestRecord(for data: [SensorValue]) -> Double {
        data.map { $0.value }.max() ?? 0
    }
}
