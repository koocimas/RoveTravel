//
//  WeatherViewModel.swift
//  RoveTravel
//

import Foundation
import WeatherKit

@MainActor
class WeatherViewModel: ObservableObject {
    private let destination: Destination
    private let weatherManager: WeatherManager

    @Published var isLoading = false
    @Published var stateText = ""
    @Published var dailyForecast: Forecast<DayWeather>?
    @Published var hourlyForecast: Forecast<HourWeather>?

    init(destination: Destination, weatherManagerHelper: WeatherManager = WeatherManager.shared) {
            self.destination = destination
            self.weatherManager = weatherManagerHelper

        fetchDailyForecast()
        }

    func fetchDailyForecast() {
            isLoading = true
            Task {
                let forecast = await weatherManager.dailyForecast(
                    lat: destination.latitude, long: destination.longitude
                )
                self.dailyForecast = forecast
                self.isLoading = false
        }
    }
}
