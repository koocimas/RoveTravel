//
//  CurrencyWidgetViewModel.swift
//  RoveTravel
//
//  Created by Sam Cook on 7/16/24.
//

import Foundation

@MainActor
class CurrencyWidgetViewModel: ObservableObject {
    private let currencyManager: CurrencyManager
    @Published var amount = 1.00
    @Published var showErrorAlert = false
    var destination: Destination
    var baseCode: String? = "USD"
    var conversionResults: Double? {
        let conversionResults = currencyManager.conversionResult
        return conversionResults
    }
    var baseCurrencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "\(baseCode ?? "USD")"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = "."
        formatter.usesGroupingSeparator = true
        return formatter
    }

    init(currencyManager: CurrencyManager = CurrencyManager.shared, amount: Double? = nil,
         showErrorAlert: Bool = false, destination: Destination, baseCode: String? = nil) {
        self.currencyManager = currencyManager
        self.amount = amount ?? 1.00
        self.showErrorAlert = showErrorAlert
        self.destination = destination
        self.baseCode = baseCode

        runConversion()
    }

    func runConversion() {
      Task {
        currencyManager.baseCode = baseCode ?? "USD"
        currencyManager.targetCode = destination.currencyCode
        currencyManager.amount = amount
        do {
          try await currencyManager.fetchConversion()
        } catch {
          print("Error fetching conversion: \(error)")
          showErrorAlert = true
        }
        objectWillChange.send()
      }
    }
}
