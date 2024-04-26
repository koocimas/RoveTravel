//
//  CurrencyWidgetView.swift
//  Rove
//

import SwiftUI

struct CurrencyWidgetView: View {
  @Environment(\.locale) private var locale
  @ObservedObject var currencyModel = CurrencyModel()
  @State private var amount: Double? = 1.0
  @State private var showErrorAlert = false
  var destination: Destination
  var baseCode: String? = "USD"
  private var conversionResults: Double? {
    let conversionResults = currencyModel.conversionResult
    return conversionResults
  }
  private var baseCurrencyFormatter: NumberFormatter {
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
        Text("\(conversionResults ?? 0.0, specifier: "%.2f")")
          .foregroundStyle(.accent)
          .font(.body)
          .fontWeight(.light)
          .multilineTextAlignment(.trailing)
      }
      HStack {
        Text(baseCode ?? "USD")
          .foregroundStyle(.accent)
          .font(.body)
          .fontWeight(.light)
          .multilineTextAlignment(.leading)
        Spacer()
        Text(destination.currencyCode ?? "USD")
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
    .alert(isPresented: $showErrorAlert) {
        Alert(
          title: Text("Error"),
          message: Text("Failed to fetch conversion. Check your network connection or try again later."),
          dismissButton: .default(Text("OK")))
    }
    .padding()
    .background(RoundedRectangle(cornerRadius: 20)
      .fill(
        LinearGradient(
          gradient: Gradient(colors: [.light, Color("DarkColor")]),
          startPoint: .leading,
          endPoint: .trailing))
    )
  }
  func runConversion() {
    Task {
      currencyModel.baseCode = baseCode ?? "USD"
      currencyModel.targetCode = destination.currencyCode
      currencyModel.amount = amount ?? 0.0
      do {
        try await currencyModel.fetchConversion()
      } catch {
        print("Error fetching conversion: \(error)")
        showErrorAlert = true
      }
    }
  }
}

struct CurrencyWidgetView_Previews: PreviewProvider {
  static var previews: some View {
    CurrencyWidgetView(destination: Destination.previewDestination[0])
  }
}
