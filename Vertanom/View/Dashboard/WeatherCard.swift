import SwiftUI

struct WeatherCard: View {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        VStack {
            if viewModel.showErrorView {
                ErrorView()
            } else if let weather = viewModel.weather {
                WeatherInfoView(weather: weather)
            } else {
                Text("Loading weather...")
                    .onAppear {
                        viewModel.requestLocationAuthorization()
                    }
            }
        }
    }
}

struct WeatherInfoView: View {
    var weather: WeatherModel

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(weather.locationName)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                Text(Date(), style: .time)
                    .font(.subheadline)
                    .foregroundStyle(Color.white)

                Spacer()
                HStack(spacing: 2) {
                    Image(systemName: weather.getIconName())
                        .foregroundStyle(Color.white)
                    Text(weather.condition)
                        .font(.headline)
                        .foregroundStyle(Color.white)
                }
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(weather.temperature)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)

                Spacer()

                Text(weather.highsLows)
                    .font(.subheadline)
                    .foregroundStyle(Color.white)
                    .alignmentGuide(.bottom) { _ in 0 }
            }
        }
        .padding()
        .background(
            weather.getGradient()
                .clipShape(RoundedRectangle(cornerRadius: 15))
        )
        .frame(maxWidth: .infinity)
        .frame(minHeight: 170)
    }
}

struct ErrorView: View {
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.yellow)
            Text("Location or Internet not available")
                .font(.headline)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: 170)
        .background(
            platformColorBackground
                .blur(radius: 10)
                .clipShape(RoundedRectangle(cornerRadius: 15))
        )
    }

    private var platformColorBackground: Color {
        #if os(macOS)
        return Color(NSColor.windowBackgroundColor)
        #else
        return Color(UIColor.systemBackground)
        #endif
    }
}

#Preview {
    WeatherCard()
}
