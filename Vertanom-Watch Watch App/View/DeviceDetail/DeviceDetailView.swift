//
//  DeviceDetailView.swift
//  Vertanom
//
//  Created by Tristan Listanco on 7/2/24.
//

import Charts
import SwiftData
import SwiftUI

func date(_ year: Int, _ month: Int, _ day: Int) -> Date {
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    return Calendar.current.date(from: components) ?? Date()
}

enum DataType: String, CaseIterable {
    case temperature = "Temperature"
    case humidity = "Humidity"
    case pH
    case soilNutrient = "Soil Nutrient"
}

enum DataRange: String, CaseIterable {
    case daily = "Daily"
    case weekly = "Weekly"
    case monthly = "Monthly"
}

struct DeviceDetailView: View {
    @ObservedObject var deviceViewModel: DeviceViewModel
    @State private var selectedDataType: DataType = .temperature
    @State private var selectedDataRange: DataRange = .daily
    @State private var selectedDeviceData: [SensorValue] = []
    @State private var showModal = false

    var averageValue: Double {
        Computations.averageValue(for: selectedDeviceData)
    }

    var latestValue: Double {
        Computations.latestValue(for: selectedDeviceData)
    }

    var dailyAverage: Double {
        Computations.dailyAverage(for: selectedDeviceData)
    }

    var weekdayAverage: Double {
        Computations.weekdayAverage(for: selectedDeviceData)
    }

    var weekendAverage: Double {
        Computations.weekendAverage(for: selectedDeviceData)
    }

    var highestRecord: Double {
        Computations.highestRecord(for: selectedDeviceData)
    }

    var body: some View {
        TabView {
            VStack(alignment: .leading, spacing: 4) {
                Chart(selectedDeviceData) { element in
                    BarMark(
                        x: .value("Time", element.date, unit: .day),
                        y: .value("Value", element.value)
                    )
                    .foregroundStyle(
                        Color.accentColor.opacity(0.7).blendMode(.overlay)
                    )

                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .chartXAxis {
                    AxisMarks(stroke: StrokeStyle(lineWidth: 0)) // Hides X axis
                }
                .chartYAxis {
                    AxisMarks(stroke: StrokeStyle(lineWidth: 0))
                }

                .animation(.default, value: selectedDeviceData)
                Spacer()
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: selectedDataType.iconName)
                            .foregroundStyle(.tertiary)
                            .opacity(0.7)
                        Text(selectedDataType.rawValue)
                            .font(.footnote)
                            .fontWeight(.bold).foregroundStyle(.tertiary)
                            .opacity(0.7)
                    }
                    Text(deviceViewModel.device.name)
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundStyle(.primary)
                        .contentTransition(.numericText())
                        .animation(.default, value: latestValue)
                    Text("\(latestValue, specifier: "%.2f")")
                        .font(.title2)
                        .foregroundStyle(.primary)
                        .fontWeight(.bold)
                        .contentTransition(.numericText())
                        .animation(.default, value: latestValue)
                        .fontDesign(.rounded)
                }
            }
            .padding(.horizontal)

            DeviceStatisticsView(dailyAverage: dailyAverage,
                                 weekdayAverage: weekdayAverage,
                                 weekendAverage: weekendAverage,
                                 highestRecord: highestRecord)

            DeviceSystemStatusControls()
        }
        .tabViewStyle(.verticalPage)
        .onAppear {
            loadData()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showModal = true
                } label: {
                    Label("View", systemImage: "line.3.horizontal.decrease.circle")
                }
                .sheet(isPresented: $showModal) {
                    DeviceViewOptionsModal(selectedDataType: $selectedDataType, loadData: loadData)
                }
            }
        }
        .foregroundStyle(.white)
    }

    func loadData() {
        switch selectedDataType {
        case .temperature:
            selectedDeviceData = deviceViewModel.device.temperatureData
        case .humidity:
            selectedDeviceData = deviceViewModel.device.humidityData
        case .pH:
            selectedDeviceData = deviceViewModel.device.pHData
        case .soilNutrient:
            selectedDeviceData = deviceViewModel.device.soilNutrientData
        }
    }
}

#Preview {
    let sampleDevice = Device(
        id: "1",
        name: "Example Device",
        location: "Sample Location",
        lastUpdated: "10:00 AM",
        status: .online,
        temperatureData: [
            SensorValue(date: date(2023, 5, 2), value: 74),
            SensorValue(date: date(2023, 5, 3), value: 62),
            SensorValue(date: date(2023, 5, 4), value: 40),
            SensorValue(date: date(2023, 5, 5), value: 78),
            SensorValue(date: date(2023, 5, 6), value: 72)
        ],
        pHData: [],
        humidityData: [],
        soilNutrientData: []
    )
    DeviceDetailView(deviceViewModel: DeviceViewModel(device: sampleDevice))
}
