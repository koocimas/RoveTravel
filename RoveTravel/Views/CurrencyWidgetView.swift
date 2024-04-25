//
//  CurrencyWidgetView.swift
//  Rove
//

import SwiftUI

struct CurrencyWidgetView: View {
  @Environment(\.locale) private var locale
  @ObservedObject var currencyModel = CurrencyModel()
  @State private var amount: Double = 1.0
  var destination: Destination
  private var convertedAmount: Double {
    currencyModel.baseCode = baseCode
    currencyModel.targetCode = destination.currencyCode
    currencyModel.amount = amount
    let conversion = amount * currencyModel.conversionRate
    return conversion
  }

  private var conversionResults: Double {
    let conversionResults = currencyModel.conversionResult
    return conversionResults
  }
  private var baseCurrencyFormatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = "\(baseCode)"
    formatter.currencySymbol = "$"
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    formatter.groupingSeparator = "."
    formatter.usesGroupingSeparator = true
    return formatter
  }
  private var targetCurrencyFormatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = "\(destination.currencyCode)"
    formatter.currencySymbol = "$"
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    formatter.groupingSeparator = "."
    formatter.usesGroupingSeparator = true
    return formatter
  }
  var baseCode = "USD"

  var body: some View {
    VStack {
      Text("Exchange Rate")
        .foregroundStyle(.accent)
        .font(.title3)
        .fontWeight(.light)
        .multilineTextAlignment(.center)
        .padding(.bottom, -10)
      HStack {
        TextField("Enter Amount", value: $amount, formatter: baseCurrencyFormatter)
          .keyboardType(.numbersAndPunctuation)
          .foregroundStyle(.accent)
          .opacity(0.5)
          .font(.body)
          .fontWeight(.light)
          .multilineTextAlignment(.leading)
        Spacer()
        Text("=")
          .foregroundStyle(.accent)
          .font(.body)
          .fontWeight(.light)
          .multilineTextAlignment(.center)
        Text("\(conversionResults, specifier: "%.2f")")
          .foregroundStyle(.accent)
          .font(.body)
          .fontWeight(.light)
          .multilineTextAlignment(.trailing)
      }
      HStack {
        Text(baseCode)
          .foregroundStyle(.accent)
          .font(.body)
          .fontWeight(.light)
          .multilineTextAlignment(.leading)
        Spacer()
        Text(destination.currencyCode)
          .foregroundStyle(.accent)
          .font(.body)
          .fontWeight(.light)
          .multilineTextAlignment(.trailing)
      }
      Button("Convert") {
        runConversion()
      }
      .buttonStyle(.bordered)
      .padding(.top, -30)
    }
    .padding()
    .background(RoundedRectangle(cornerRadius: 20)
      .fill(          LinearGradient(gradient: Gradient(colors: [.light, Color("DarkColor")]), startPoint: .leading, endPoint: .trailing))
    )
  }
  func runConversion() {
    Task {
      currencyModel.baseCode = baseCode
      currencyModel.targetCode = destination.currencyCode
      currencyModel.amount = amount
      do {
        try await currencyModel.fetchConversion()
      }
    }
  }
}

struct CurrencyWidgetView_Previews: PreviewProvider {
  static var previews: some View {
    CurrencyWidgetView(destination: Destination.previewDestination[0])
  }
}
