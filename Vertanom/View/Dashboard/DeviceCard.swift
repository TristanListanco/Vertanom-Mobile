import SwiftUI

struct DeviceCard: View {
    @ObservedObject var viewModel: DeviceViewModel
    
    var body: some View {
        NavigationLink(destination: DeviceDetailView(deviceViewModel: viewModel)) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.device.name)
                        .font(.headline)
                    HStack(spacing: 4) {
                        Image(systemName: "location.fill")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(viewModel.device.location)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
    
    struct DeviceCard_Previews: PreviewProvider {
        static var previews: some View {
            let sampleSensorData = [
                SensorValue(date: Date(), value: 50),
                SensorValue(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, value: 55),
                SensorValue(date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, value: 60)
            ]
            
            let sampleDevice = Device(
                id: "1",
                name: "Example Device",
                location: "Sample Location",
                lastUpdated: "10:00 AM",
                status: .online,
                temperatureData: sampleSensorData,
                pHData: sampleSensorData,
                humidityData: sampleSensorData,
                soilNutrientData: sampleSensorData
            )
            
            let viewModel = DeviceViewModel(device: sampleDevice)
            @Namespace var namespace
            
            return DeviceCard(viewModel: viewModel)
        }
    }
}
