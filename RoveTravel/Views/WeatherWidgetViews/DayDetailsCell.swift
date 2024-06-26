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
          .foregroundStyle(.accent)
          .fontWeight(.light)
          .font(.body)
          .multilineTextAlignment(.center)
        Image(systemName: day.symbolName)
          .foregroundStyle(.accent)
          .fontWeight(.light)
          .font(.body)
          .shadow(radius: Constants.General.dayDetailCellPadding)
          .multilineTextAlignment(.center)
          .padding(Constants.General.dayDetailCellPadding)
        Text("H: \(Int(day.highTemperature.converted(to: .fahrenheit).value))°")
          .foregroundStyle(.accent)
          .fontWeight(.light)
          .font(.caption)
          .multilineTextAlignment(.center)
        Text("L: \(Int(day.lowTemperature.converted(to: .fahrenheit).value))°")
          .foregroundStyle(.accent)
          .fontWeight(.light)
          .font(.caption)
          .multilineTextAlignment(.center)
      }
    }
  }
}

#Preview {
  DayDetailsCell()
}
