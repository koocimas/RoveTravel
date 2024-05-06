//
//  CurrencyWidgetView.swift
//  Rove
//

import SwiftUI

struct CurrencyWidgetView: View {
  @Environment(\.locale) private var locale
  @ObservedObject var currencyManager = CurrencyManager()
  @State private var amount: Double? = 1.00
  @State private var showErrorAlert = false
  var destination: Destination
  var baseCode: String? = "USD"
  private var conversionResults: Double? {
    let conversionResults = currencyManager.conversionResult
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
      HStack {
        TextField("Enter $(amount)", value: $amount, formatter: baseCurrencyFormatter)
          .keyboardType(.numbersAndPunctuation)
          .submitLabel(.done)
          .onSubmit {
            runConversion()
          }
          .onAppear {
            runConversion()
          }
          .foregroundStyle(.accent)
          .opacity(Constants.General.currencyTextFieldOpacity)
          .font(.body)
          .fontWeight(.light)
          .multilineTextAlignment(.leading)
          .textFieldStyle(.roundedBorder)
          .lineLimit(Constants.General.currencyTextFieldLineLimit)
        Spacer()
        Text("= \(conversionResults ?? 0.0, specifier: "%.2f")")
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
    }
    .alert(isPresented: $showErrorAlert) {
      Alert(
        title: Text("Error"),
        message: Text("Failed to fetch conversion. Check your network connection or try again later."),
        dismissButton: .default(Text("OK")))
    }
    .padding()
    .background(RoundedRectangle(cornerRadius: Constants.General.roundRectCornerRadius)
      .fill(
        LinearGradient(
          gradient: Gradient(colors: [.light, .dark]),
          startPoint: .leading,
          endPoint: .trailing))
    )
  }
  func runConversion() {
    Task {
      currencyManager.baseCode = baseCode ?? "USD"
      currencyManager.targetCode = destination.currencyCode
      currencyManager.amount = amount ?? 0.0
      do {
        try await currencyManager.fetchConversion()
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
