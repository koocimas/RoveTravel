//
//  CurrencyManager.swift
//  Rove
//

import Foundation

class CurrencyManager: ObservableObject {
  @Published var amount: Double? = 0
  @Published var baseCode: String? = ""
  @Published var targetCode: String? = ""
  @Published var conversionResult = 0.00
  @Published var conversionRate = 0.00

  func fetchConversion() async throws {
      let apiKey = currencyApiKey
      let urlString =
      "https://v6.exchangerate-api.com/v6/pair/\(baseCode ?? "USD")/\(targetCode ?? "USD")/\(amount ?? 0)"
      guard let url = URL(string: urlString) else {
        print("Error here")
        return
      }
      var request = URLRequest(url: url)
      request.httpMethod = "GET"
      request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization"
      )
      do {
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
          print("Error here too")
          return
        }

        if (200..<300).contains(httpResponse.statusCode) {
          let decodedResponse = try JSONDecoder().decode(CurrencyResults.self, from: data)

          await MainActor.run {
            self.conversionResult = decodedResponse.conversionResult
          }
        } else {
          print("HTTP status code for currency: \(httpResponse.statusCode)")
        }
      } catch {
        print("Error fetching data: \(error)")
      }
  }
  var currencyApiKey: String {
    guard let filePath = Bundle.main.path(forResource: "Currency-Info", ofType: "plist") else {
      fatalError("Couldn't find file 'Currency-Info.plist'.")
    }
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "API_KEY") as? String else {
      fatalError("Couldn't find key 'API_KEY' in 'Currency-Info.plist'.")
    }
    return value
  }
}
