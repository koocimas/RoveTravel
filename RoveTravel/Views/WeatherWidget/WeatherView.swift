//
//  WeatherView.swift
//  RoveTravel
//

import SwiftUI
import Charts
import CoreLocation
import WeatherKit

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
  var body: some View {
      VStack {
          if viewModel.isLoading {
          ProgressView()
        }
        ScrollView {
          VStack {
              if let daily = viewModel.dailyForecast {
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
    let viewModel = WeatherViewModel(destination: Destination.previewDestination[0])
    return WeatherView(viewModel: viewModel)}
