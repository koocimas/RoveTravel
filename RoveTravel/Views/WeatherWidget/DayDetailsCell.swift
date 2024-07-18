//
//  DayDetailsCell.swift
//  RoveTravel
//

import SwiftUI
import WeatherKit

struct DayDetailsCell: View {
    var dayWeather: DayWeather?

    var body: some View {
        if let day = dayWeather {
            VStack {
                Text(day.date.formatted(.dateTime.weekday()))
                    .weatherDetailStyle(font: .body)
                Image(systemName: day.symbolName)
                    .weatherDetailStyle(font: .body)
                    .shadow(radius: Constants.General.dayDetailCellPadding)
                    .padding(Constants.General.dayDetailCellPadding)
                Text("H: \(Int(day.highTemperature.converted(to: .fahrenheit).value))°")
                    .weatherDetailStyle(font: .caption)
                Text("L: \(Int(day.lowTemperature.converted(to: .fahrenheit).value))°")
                    .weatherDetailStyle(font: .caption)
            }
        }
    }
}

#Preview {
    DayDetailsCell()
}

private extension View {
    func weatherDetailStyle(font: Font) -> some View {
        foregroundStyle(.accent)
            .font(font)
            .fontWeight(.light)
            .multilineTextAlignment(.center)
    }
}
