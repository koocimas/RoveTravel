//
//  CurrencyWidgetView.swift
//  Rove
//

import SwiftUI

struct CurrencyWidgetView: View {
    @ObservedObject var viewModel: CurrencyWidgetViewModel

  var body: some View {
    VStack {
      Text("Currency Converter")
        .foregroundStyle(.accent)
        .font(.title3)
        .fontWeight(.light)
        .multilineTextAlignment(.center)
      HStack {
          TextField("Enter $(amount)", value: $viewModel.amount, formatter: viewModel.baseCurrencyFormatter)
          .keyboardType(.numbersAndPunctuation)
          .submitLabel(.done)
          .onSubmit {
              viewModel.runConversion()
          }
          .foregroundStyle(.accent)
          .opacity(Constants.General.currencyTextFieldOpacity)
          .font(.body)
          .fontWeight(.light)
          .multilineTextAlignment(.leading)
          .textFieldStyle(.roundedBorder)
          .lineLimit(Constants.General.currencyTextFieldLineLimit)
        Spacer()
          Text("= \(viewModel.conversionResults ?? 0.0, specifier: "%.2f")")
          .foregroundStyle(.accent)
          .font(.body)
          .fontWeight(.light)
          .multilineTextAlignment(.trailing)
      }
      HStack {
          Text(viewModel.baseCode ?? "USD")
          .foregroundStyle(.accent)
          .font(.body)
          .fontWeight(.light)
          .multilineTextAlignment(.leading)
        Spacer()
          Text(viewModel.destination.currencyCode ?? "USD")
          .foregroundStyle(.accent)
          .font(.body)
          .fontWeight(.light)
          .multilineTextAlignment(.trailing)
      }
    }
    .alert(isPresented: $viewModel.showErrorAlert) {
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
}

#Preview {
    let viewModel = CurrencyWidgetViewModel(destination: Destination.previewDestination[0])
    return CurrencyWidgetView(viewModel: viewModel)}
