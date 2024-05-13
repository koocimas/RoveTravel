//
//  SnapshotView.swift
//  Rove
//

import SwiftUI
import WeatherKit

struct SnapshotView: View {
  var destination: Destination
  var timeResults: TimeResults
  var body: some View {
    ScrollView {
      TimeWidgetView(timeResults: timeResults, destination: destination)
      WeatherView(location: destination)
      CurrencyWidgetView(destination: destination)
      NewsView(destination: destination)
    }
    .padding()
    .background(
      AngularGradient(
        gradient: Gradient(colors: [.dark, .light]),
        center: .topLeading, startAngle: .degrees(Constants.General.startAngle),
        endAngle: .degrees(Constants.General.endAngle))
    )
  }
}

#Preview {
  SnapshotView(destination: Destination.previewDestination[0], timeResults: TimeResults.timeExample)
}
