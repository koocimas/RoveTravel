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
      TimeWidgetView(destination: destination, timeResults: timeResults)
      CurrencyWidgetView(destination: destination)
      NewsView(destination: destination)
    }
    .padding()
    .background(
      AngularGradient(gradient: Gradient(colors: [Color("DarkColor"), .light]), center: .topLeading, startAngle: .degrees(90), endAngle: .degrees(20))
    )
  }
}

#Preview {
  SnapshotView(destination: Destination.previewDestination[0], timeResults: TimeResults.timeExample)
}


