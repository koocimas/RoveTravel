//
//  Destination.swift
//  Rove
//

import Foundation
import CoreLocation

struct Destination: Identifiable, Hashable {
  var id: Int
  var city: String
  var country: String
  var currencyCode: String? 
  var latitude: Double
  var longitude: Double
  var location: CLLocation {
    CLLocation(latitude: latitude, longitude: longitude)
  }
}

extension Destination {
  static var previewDestination: [Destination] {
    return [
      Destination(id: 1, city: "Amman", country: "Jordan", currencyCode: "JOD", latitude: 31.9544, longitude: 35.9106),
      Destination(id: 2, city: "Amsterdam", country: "Netherlands", currencyCode: "EUR", latitude: 52.3676, longitude: 4.9041),
      Destination(id: 3, city: "Bali", country: "Indonesia", currencyCode: "IDR", latitude: -8.4095, longitude: 115.1889),
      Destination(id: 4, city: "Bangkok", country: "Thailand", currencyCode: "THB", latitude: 13.7563, longitude: 100.5018),
      Destination(id: 5, city: "Barcelona", country: "Spain", currencyCode: "EUR", latitude: 41.3874, longitude: 2.1686),
      Destination(id: 6, city: "Beijing", country: "China", currencyCode: "CNY", latitude: 39.9042, longitude: 116.4074),
      Destination(id: 7, city: "Beirut", country: "Lebanon", currencyCode: "LBP", latitude: 33.8938, longitude: 35.5018),
      Destination(id: 8, city: "Berlin", country: "Germany", currencyCode: "EUR", latitude: 52.5200, longitude: 13.4050),
      Destination(id: 9, city: "Budapest", country: "Hungary", currencyCode: "HUF", latitude: 47.4979, longitude: 19.0402),
      Destination(id: 10, city: "Buenos Aires", country: "Argentina", currencyCode: "ARS", latitude: -34.6037, longitude: -58.3816),
      Destination(id: 11, city: "Cairo", country: "Egypt", currencyCode: "EGP", latitude: 30.0444, longitude: 31.2357),
      Destination(id: 12, city: "Cancun", country: "Mexico", currencyCode: "MXN", latitude: 21.1619, longitude: -86.8515),
      Destination(id: 13, city: "Cape Town", country: "South Africa", currencyCode: "ZAR", latitude: -33.9221, longitude: 18.4231),
      Destination(id: 14, city: "Delhi", country: "India", currencyCode: "INR", latitude: 28.7041, longitude: 77.1025),
      Destination(id: 15, city: "Hanoi", country: "Vietnam", currencyCode: "VND", latitude: 21.0278, longitude: 105.8342),
      Destination(id: 16, city: "Istanbul", country: "Turkey", currencyCode: "TRY", latitude: 41.0082, longitude: 28.9784),
      Destination(id: 17, city: "Lima", country: "Peru", currencyCode: "PEN", latitude: -12.0464, longitude: -77.0428),
      Destination(id: 18, city: "Lisbon", country: "Portugal", currencyCode: "EUR", latitude: 38.7223, longitude: -9.1393),
      Destination(id: 19, city: "London", country: "England", currencyCode: "GBP", latitude: 51.5072, longitude: -0.1276),
      Destination(id: 20, city: "Melbourne", country: "Australia", currencyCode: "AUD", latitude: 37.8136, longitude: 144.9631),
      Destination(id: 21, city: "Montreal", country: "Canada", currencyCode: "CAD", latitude: 45.5019, longitude: -73.5674),
      Destination(id: 22, city: "Mykonos", country: "Greece", currencyCode: "EUR", latitude: 37.4415, longitude: 25.3667),
      Destination(id: 23, city: "New York City", country: "United States", currencyCode: "USD", latitude: 40.7128, longitude: -74.0060),
      Destination(id: 24, city: "Paris", country: "France", currencyCode: "EUR", latitude: 48.8566, longitude: 2.3522),
      Destination(id: 25, city: "Rio de Janeiro", country: "Brazil", currencyCode: "BRL", latitude: -22.9068, longitude: -43.1729),
      Destination(id: 26, city: "Rome", country: "Italy", currencyCode: "EUR", latitude: 41.8967, longitude: 12.4822),
      Destination(id: 28, city: "Soeul", country: "South Korea", currencyCode: "KRW", latitude: 37.5519, longitude: 126.9918),
      Destination(id: 29, city: "Split", country: "Croatia", currencyCode: "EUR", latitude: 43.5147, longitude: 16.4435),
      Destination(id: 30, city: "Tokyo", country: "Japan", currencyCode: "JPY", latitude: 35.6764, longitude: 139.6500)
    ]
  }
}
