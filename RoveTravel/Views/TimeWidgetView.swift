//
//  TimeWidgetView.swift
//  Rove
//

import SwiftUI

struct TimeWidgetView: View {
  @ObservedObject var timeManager = TimeManager.shared
  @State var timeResults: TimeResults = TimeResults.timeExample
  var destination: Destination
  private var destinationDateTime: String {
    let newTime = timeManager.dateTime
    return newTime
  }
  private var destinationTimeZone: String? {
    let timeZone = timeManager.timeZone
    return timeZone
  }
  private var dayOfWeek: String? {
    let day = timeManager.dayOfWeek
    return day
  }
  var body: some View {
    VStack {
      HStack {
        VStack {
          HStack {
            Text("\(dayOfWeek ?? "Weekday unavailable"),")
            Text(dateFormatTime(date: "\(destinationDateTime)"), format: .dateTime.day().month().year())
          }
          .foregroundStyle(.accent)
          .font(.title3)
          .multilineTextAlignment(.center)
          .fontWeight(.light)
          Text(timeIn12HourFormat(from: dateFormatTime(date: "\(destinationDateTime)")))
            .foregroundStyle(.accent)
            .fontWeight(.light)
            .font(.body)
            .multilineTextAlignment(.center)
          Text("Timezone: \(destinationTimeZone ?? "Timezone unavailable")")
            .foregroundStyle(.accent)
            .font(.caption)
            .fontWeight(.light)
            .multilineTextAlignment(.center)
          Text("")
        }
        .task {
          let latitude = Float(destination.latitude)
          let longitude = Float(destination.longitude)
          async let firstTimeVar: () = timeManager.fetchDateTime(
            latitude: latitude,
            longitude: longitude)
          async let secondTimeVar: () = timeManager.fetchTimeZone(
            latitude: latitude,
            longitude: longitude)
          async let thirdTimeVar: () = timeManager.fetchDayOfWeek(
            latitude: latitude,
            longitude: longitude)
          let _: [()] = await [firstTimeVar, secondTimeVar, thirdTimeVar]
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
  TimeWidgetView(timeResults: TimeResults.timeExample, destination: Destination.previewDestination[0])
}
