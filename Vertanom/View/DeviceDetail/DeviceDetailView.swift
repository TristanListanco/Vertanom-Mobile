import Charts
import SwiftUI
import TipKit

struct SalesSummary: Identifiable, Equatable {
    let weekday: Date
    var value: Int

    var id: Date { weekday }
}

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

    let monitordeviceTip = MonitorData()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                TipView(monitordeviceTip)
                Picker("Data Range", selection: $selectedDataRange) {
                    ForEach(DataRange.allCases, id: \.self) { range in
                        Text(range.rawValue).tag(range)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom)
                GroupBox {
                    VStack(alignment: .leading) {
                        Text("Latest Data:")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(latestValue, format: .number)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .contentTransition(.numericText())
                            .animation(.default, value: latestValue)
                            .fontDesign(.rounded)
                        Text("TODAY")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Chart(selectedDeviceData) { element in
                        BarMark(
                            x: .value("Time", element.date, unit: .day),
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
                    .animation(.default, value: selectedDeviceData)
                    .frame(height: 200)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Text("On Average the Air Quality of the farm is 20 Parts per Million (ppm) which is appropriate for crop growing and cultivating.")
                    .font(.subheadline)

                #if os(macOS)
                Form {
                    Section(header: Text("Statistical Analysis")) {
                        LabeledContent("Daily Average", value: "\(dailyAverage.formatted()) ppm")
                            .contentTransition(.numericText())
                            .animation(.default, value: latestValue)

                        LabeledContent("Weekday Average", value: "\(weekdayAverage.formatted()) ppm")
                            .contentTransition(.numericText())
                            .animation(.default, value: latestValue)

                        LabeledContent("Weekend Average", value: "\(weekendAverage.formatted()) ppm")
                            .contentTransition(.numericText())
                            .animation(.default, value: latestValue)

                        LabeledContent("Highest Record", value: "\(highestRecord.formatted()) ppm")
                            .contentTransition(.numericText())
                            .animation(.default, value: latestValue)
                    }

                    Section(header: Text("Data Records")) {
                        Table(selectedDeviceData) {
                            TableColumn("Date") { element in
                                Text(element.date, format: .dateTime.month().day().year())
                                    .animation(.default, value: latestValue)
                                    .contentTransition(.numericText())
                            }
                            TableColumn("Value") { element in
                                Text("\(element.value) ppm")
                                    .animation(.default, value: latestValue)
                                    .contentTransition(.numericText())
                            }
                            TableColumn("Status") { _ in
                                Text("NORMAL")
                            }
                        }
                        .animation(.default, value: selectedDeviceData)
                    }
                }
                .formStyle(.grouped)
                #else
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
                GroupBox {}
                Section(header: Text("Data Records")) {
                    Table(selectedDeviceData) {
                        TableColumn("Date") { element in
                            Text(element.date, format: .dateTime.month().day().year())
                                .animation(.default, value: latestValue)
                                .contentTransition(.numericText())
                        }
                        TableColumn("Value") { element in
                            Text("\(element.value) ppm")
                                .animation(.default, value: latestValue)
                                .contentTransition(.numericText())
                        }
                        TableColumn("Status") { _ in
                            Text("NORMAL")
                        }
                    }
                    .animation(.default, value: selectedDeviceData)
                }
                #endif

                Spacer()
            }
            .padding()
            .navigationTitle(deviceViewModel.device.name)
        }
        .onAppear {
            loadData()
        }
//        .onChange(of: selectedDataRange) { _ in
//            filterDataByRange()
//        }
        .onChange(of: selectedDataType) { _ in
            loadData()
        }
        .toolbar {
            ToolbarItem {
                Menu {
                    Label("View Options", systemImage: "eye")
                        .font(.headline)
                    Divider()
                    ForEach(DataType.allCases, id: \.self) { type in
                        Button {
                            selectedDataType = type
                            loadData()
                        } label: {
                            if selectedDataType == type {
                                Label(type.rawValue, systemImage: "checkmark")
                            } else {
                                Text(type.rawValue)
                            }
                        }
                    }
                    Divider()
                    Button(role: .destructive) {
                        // Action for Reset Data
                    } label: {
                        Label("Reset Data", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "chart.bar.xaxis")
                        .imageScale(.medium)
                        .font(.system(size: 24))
                }
            }
        }
    }

    func loadData() {
        Task {
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
            // filterDataByRange()
        }
    }

    func filterDataByRange() {
        let calendar = Calendar.current
        let now = Date()

        switch selectedDataRange {
        case .daily:
            selectedDeviceData = selectedDeviceData.filter { calendar.isDateInToday($0.date) }
        case .weekly:
            if let weekAgo = calendar.date(byAdding: .day, value: -7, to: now) {
                selectedDeviceData = selectedDeviceData.filter { $0.date >= weekAgo }
            }
        case .monthly:
            if let monthAgo = calendar.date(byAdding: .month, value: -1, to: now) {
                selectedDeviceData = selectedDeviceData.filter { $0.date >= monthAgo }
            }
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
