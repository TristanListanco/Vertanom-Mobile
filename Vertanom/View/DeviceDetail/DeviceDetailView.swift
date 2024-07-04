//
//  DeviceDetailView.swift
//  Vertanom
//
//  Created by Tristan Listanco on 7/2/24.
//

import Charts
import SwiftUI

struct SalesSummary: Identifiable, Equatable {
    let weekday: Date
    var value: Int

    var id: Date { weekday }
}

enum City {
    case cupertino
    case sanFrancisco
}

func date(_ year: Int, _ month: Int, _ day: Int) -> Date {
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    return Calendar.current.date(from: components) ?? Date()
}

let cupertinoData: [SalesSummary] = [
    SalesSummary(weekday: date(2023, 5, 2), value: 74), // Last Monday
    SalesSummary(weekday: date(2023, 5, 3), value: 62), // Last Tuesday
    SalesSummary(weekday: date(2023, 5, 4), value: 40), // Last Wednesday
    SalesSummary(weekday: date(2023, 5, 5), value: 78), // Last Thursday
    SalesSummary(weekday: date(2023, 5, 6), value: 72), // Last Friday
]

let sanFranciscoData: [SalesSummary] = [
    SalesSummary(weekday: date(2023, 5, 2), value: 48), // Last Monday
    SalesSummary(weekday: date(2023, 5, 3), value: 20), // Last Tuesday
    SalesSummary(weekday: date(2023, 5, 4), value: 30), // Last Wednesday
    SalesSummary(weekday: date(2023, 5, 5), value: 56), // Last Thursday
    SalesSummary(weekday: date(2023, 5, 6), value: 70), // Last Friday
]
struct DeviceDetailView: View {
    @State var city: City = .cupertino
    @ObservedObject var deviceViewModel: DeviceViewModel
    let avg = 65.2

    var selectedCityData: [SalesSummary] {
        switch city {
        case .cupertino:
            return cupertinoData
        case .sanFrancisco:
            return sanFranciscoData
        }
    }

    var averageValue: Double {
        let total = selectedCityData.reduce(0) { $0 + $1.value }
        return selectedCityData.isEmpty ? 0 : Double(total) / Double(selectedCityData.count)
    }

    var latestValue: Int {
        selectedCityData.last?.value ?? 0
    }

    var dailyAverage: Double {
        let days = Set(selectedCityData.map { Calendar.current.component(.weekday, from: $0.weekday) })
        let total = selectedCityData.reduce(0) { $0 + $1.value }
        return days.isEmpty ? 0 : Double(total) / Double(days.count)
    }

    var weekdayAverage: Double {
        let weekdays = selectedCityData.filter { !Calendar.current.isDateInWeekend($0.weekday) }
        let total = weekdays.reduce(0) { $0 + $1.value }
        return weekdays.isEmpty ? 0 : Double(total) / Double(weekdays.count)
    }

    var weekendAverage: Double {
        let weekends = selectedCityData.filter { Calendar.current.isDateInWeekend($0.weekday) }
        let total = weekends.reduce(0) { $0 + $1.value }
        return weekends.isEmpty ? 0 : Double(total) / Double(weekends.count)
    }

    var highestRecord: Int {
        selectedCityData.map { $0.value }.max() ?? 0
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Picker("City", selection: $city.animation(.easeInOut)) {
                Text("Cupertino").tag(City.cupertino)
                Text("San Francisco").tag(City.sanFrancisco)
            }
            .pickerStyle(.segmented)

            GroupBox {
                VStack(alignment: .leading) {
                    Text("Latest Data:")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(latestValue, format: .number)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .contentTransition(.numericText())
                        .fontDesign(.rounded)
                    Text("TODAY")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Chart(selectedCityData) { element in
                    BarMark(
                        x: .value("Time", element.weekday, unit: .day),
                        y: .value("Value", element.value)
                    )
                    .foregroundStyle(.opacity(0.4))
                    RuleMark(
                        y: .value("Average", averageValue)
                    )
                    .lineStyle(StrokeStyle(lineWidth: 3))
                    .annotation(position: .top, alignment: .leading) {
                        Text("Average: \(averageValue, format: .number)")
                            .font(.footnote)
                            .fontDesign(.rounded)
                            .contentTransition(.numericText())
                            .foregroundStyle(.purple)
                    }
                }
                .frame(height: 200)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Text("On Average the Air Quality of the farm is 20 Parts per Million (ppm) which appropriate for crop growing and cultivating.")
                .font(.subheadline)

            GroupBox {
                LabeledContent("Daily Average", value: "\(dailyAverage.formatted()) ppm")
                    .contentTransition(.numericText())
                    .fontWeight(.medium)
            }

            GroupBox {
                LabeledContent("Weekday Average", value: "\(weekdayAverage.formatted()) ppm")
                    .contentTransition(.numericText())
                    .fontWeight(.medium)
            }

            GroupBox {
                LabeledContent("Weekend Average", value: "\(weekendAverage.formatted()) ppm")
                    .contentTransition(.numericText())
                    .fontWeight(.medium)
            }

            GroupBox {
                LabeledContent("Highest Record:", value: "\(highestRecord.formatted()) ppm")
                    .contentTransition(.numericText())
                    .fontWeight(.medium)
            }
            Spacer()
        }

        .padding()
        .navigationTitle(deviceViewModel.device.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DeviceDetailView(deviceViewModel: DeviceViewModel(device: Device(id: "1", name: "Example Device", location: "Sample Location", lastUpdated: "10:00 AM", status: "Running")))
}
