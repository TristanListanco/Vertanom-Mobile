//
//  DeviceStatisticsView.swift
//  Vertanom-Watch Watch App
//
//  Created by Tristan Listanco on 7/26/24.
//

import SwiftUI


struct DeviceStatisticsView: View {
    var dailyAverage: Double
    var weekdayAverage: Double
    var weekendAverage: Double
    var highestRecord: Double

    var body: some View {
        List {
            LabeledContent("Daily Average:", value: "\(dailyAverage.formatted(.number.precision(.fractionLength(2)))) ppm")
                .contentTransition(.numericText())
            LabeledContent("Weekday Average:", value: "\(weekdayAverage.formatted(.number.precision(.fractionLength(2)))) ppm")
                .contentTransition(.numericText())
            LabeledContent("Weekend Average:", value: "\(weekendAverage.formatted(.number.precision(.fractionLength(2)))) ppm")
                .contentTransition(.numericText())
            LabeledContent("Highest Value:", value: "\(highestRecord.formatted(.number.precision(.fractionLength(2)))) ppm")
                .contentTransition(.numericText())
        }
        .padding(.horizontal)
        .navigationTitle("Data")
    }
}

#Preview {
    DeviceStatisticsView(
        dailyAverage: 72.34,
        weekdayAverage: 75.12,
        weekendAverage: 70.45,
        highestRecord: 80
    )
}
