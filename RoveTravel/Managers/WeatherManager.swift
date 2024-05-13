//
//  WeatherManager.swift
//  RoveTravel
//
//  Created by Sam Cook on 5/12/24.
//

import Foundation
import WeatherKit

@MainActor class WeatherManager: ObservableObject {
  private let weatherService = WeatherService()
  @Published var weather: Weather?
  static let shared = WeatherManager()
  private let service = WeatherService.shared

  func getWeather(lat: Double, long: Double) async {
    do {
      weather = try await Task.detached(priority: .userInitiated) { [weak self] in
        return try await self?.weatherService.weather(for: .init(latitude: lat, longitude: long))
      }.value

    } catch {
      print("Failed to get weather data. \(error)")
    }
  }

  var symbol: String {
    guard let symbolName = weather?.currentWeather.symbolName else { return "--" }

    return symbolName
  }

  var temperature: String {
    guard let temp = weather?.currentWeather.temperature else { return "--" }
    let convert = temp.converted(to: .fahrenheit).value

    return String(Int(convert)) + "°F"
  }

  func dailyForecast(lat: Double, long: Double) async -> Forecast<DayWeather>? {
    let dayWeather = await Task.detached(priority: .userInitiated) {
      let forecast = try? await self.service.weather(
        for: .init(latitude: lat, longitude: long),
        including: .daily)
      return forecast
    }.value
    return dayWeather
  }
  enum WeatherManagerHelper {
    public static func findDailyTempMinMax(_ daily: Forecast<DayWeather>) -> (min: Double, max: Double) {
      let minElement = daily.min { valA, valB in
        valA.lowTemperature.value < valB.lowTemperature.value
      }
      let min = minElement?.lowTemperature.converted(to: .fahrenheit).value ?? 0

      let maxElement = daily.max { valA, valB in
        valA.highTemperature.value < valB.highTemperature.value
      }
      let max = maxElement?.highTemperature.converted(to: .fahrenheit).value ?? 200

      return (min, max)
    }
  }
}
