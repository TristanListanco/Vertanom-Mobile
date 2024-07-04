//
//  WeatherCard.swift
//  Vertanom
//
//  Created by Tristan Listanco on 7/1/24.
//

import SwiftUI

struct WeatherCard: View {
    var location: String
    var time: String
    var condition: String
    var temperature: String
    var highsLows: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 1) {
                Text(location)
                    .font(.headline)
                    .fontWeight(.bold)

                Text(time)
                    .font(.caption2)
                    .foregroundColor(.secondary)

                Spacer()
                HStack(spacing: 1) {
                    Image(systemName: "sun.max.fill")
                        .font(.caption)
                    Text(condition)
                        .font(.caption)
                }
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 1) {
                Text(temperature)
                    .font(.title)
                    .fontWeight(.bold)

                Spacer()

                Text(highsLows)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .alignmentGuide(.bottom) { _ in 0 }
            }
        }
        .padding(8)
        .background(Color.secondary)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .frame(maxWidth: .infinity)
        .frame(minHeight: 120) // Adjusted minimum height for watchOS
    }
}



#Preview {
    WeatherCard(
        location: "San Francisco",
        time: "10:00 AM",
        condition: "Sunny",
        temperature: "25°C",
        highsLows: "H: 27°C, L: 18°C"
    )
}
