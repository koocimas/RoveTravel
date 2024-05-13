//
//  WeatherWidgetView.swift
//  RoveTravel
//
//  Created by Sam Cook on 5/12/24.
//

import SwiftUI
import Charts
import CoreLocation
import WeatherKit

struct WeatherWidgetView: View {
  var location: Destination
  var weatherManagerHelper = WeatherManager.shared
  @State var isLoading = false
  @State var stateText = ""
  @State var dailyForecast: Forecast<DayWeather>?
  @State var hourlyForecast: Forecast<HourWeather>?

  var body: some View {
      VStack {
        if isLoading {
          ProgressView()
        }
        ScrollView {
          VStack {
            if let daily = dailyForecast {
              Text("Weather Forecast")
                .foregroundStyle(.accent)
                .font(.title3)
                .multilineTextAlignment(.center)
                .fontWeight(.light)
                .padding(.bottom, Constants.General.weatherTitlePadding)
              ScrollView(.horizontal) {
                HStack(spacing: Constants.General.weatherHStackSpacing) {
                  ForEach(daily, id: \.date) { day in
                    DayDetailsCell(dayWeather: day)
                  }
                }
                .frame(height: Constants.General.weatherHStackFrameHeight)
              }
              .padding(.horizontal, Constants.General.weatherWidgetPadding)
            }
          }
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      .task {
        isLoading = true
        Task.detached {
          dailyForecast = await weatherManagerHelper.dailyForecast(lat: location.latitude, long: location.longitude
          )
          isLoading = false
        }
      }
    .padding()
    .frame(maxWidth: .infinity)
    .background(RoundedRectangle(cornerRadius: Constants.General.roundRectCornerRadius)
      .fill(LinearGradient(
        gradient: Gradient(colors: [.light, .dark]),
        startPoint: .leading,
        endPoint: .trailing)).ignoresSafeArea()
    )
  }
}

#Preview {
  WeatherWidgetView(location: Destination.previewDestination[0])
}
