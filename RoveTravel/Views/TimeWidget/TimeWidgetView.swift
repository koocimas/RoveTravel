//
//  TimeWidgetView.swift
//  Rove
//

import SwiftUI

struct TimeWidgetView: View {
    @ObservedObject var viewModel: TimeWidgetViewModel
//    @StateObject var viewModelTwo = TimeWidgetViewModel()
// swiftlint:disable:next line_length
//    stateObject option makes it not testable since it is instantiated inside of the view. Will hold onto the viewmodel instead of recreating it

  var body: some View {
    VStack {
      HStack {
        VStack {
          HStack {
              Text(viewModel.dayOfWeekAndDate)
          }
          .foregroundStyle(.accent)
          .font(.title3)
          .multilineTextAlignment(.center)
          .fontWeight(.light)

            Text(viewModel.destinationTime)
            .foregroundStyle(.accent)
            .fontWeight(.light)
            .font(.body)
            .multilineTextAlignment(.center)

            Text(viewModel.destinationTimeZone)
            .foregroundStyle(.accent)
            .font(.caption)
            .fontWeight(.light)
            .multilineTextAlignment(.center)
            .padding(.trailing)
        }
      }
    }
    .padding([.horizontal, .top])
    .padding(.bottom, Constants.General.timeWidgetPadding)
    .frame(maxWidth: .infinity)
    .background(RoundedRectangle(cornerRadius: Constants.General.roundRectCornerRadius)
      .fill(LinearGradient(
        gradient: Gradient(colors: [.light, .dark]),
        startPoint: .leading,
        endPoint: .trailing))
    )
  }
}

#Preview {
    let viewModel = TimeWidgetViewModel(destination: Destination.previewDestination[0])
    return TimeWidgetView(viewModel: viewModel)
}
