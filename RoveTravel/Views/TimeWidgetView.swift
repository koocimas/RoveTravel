//
//  TimeWidgetView.swift
//  Rove
//

import SwiftUI

struct TimeWidgetView: View {
  var destination: Destination
  @ObservedObject var timeManager = TimeManager()
  @State var timeResults: TimeResults = TimeResults.timeExample
  private var destinationDateTime: String {
    let newTime = timeManager.dateTime
    return newTime
  }
  private var destinationTimeZone: String {
    let timeZone = timeManager.timeZone
    return timeZone
  }
  private var dayOfWeek: String {
    let day = timeManager.dayOfWeek
    return day
  }

  var body: some View {
    VStack {
      HStack {
        VStack {
          Text("\(dayOfWeek), \(dateFormatTime(date: "\(destinationDateTime)"), format: .dateTime.day().month().year())")
            .accessibilityIdentifier("dayOfWeekLabel")
            .foregroundStyle(.accent)
            .font(.title3)
            .multilineTextAlignment(.center)
            .fontWeight(.light)
          Text(timeIn12HourFormat(from: dateFormatTime(date: "\(destinationDateTime)")))
            .accessibilityIdentifier("timeLabel")
            .foregroundStyle(.accent)
            .fontWeight(.light)
            .font(.body)
            .multilineTextAlignment(.center)
          Text("Timezone: \(destinationTimeZone)")
            .accessibilityIdentifier("timeZoneLabel")
            .foregroundStyle(.accent)
            .font(.caption)
            .fontWeight(.light)
            .multilineTextAlignment(.center)
          Text("")
        }
        .task {
          do {
            getTime()
            getZone()
            getDay()
          }
        }

      }
    }
    .padding([.horizontal, .top])
    .padding(.bottom, 5)
    .frame(maxWidth: .infinity)
    .background(RoundedRectangle(cornerRadius: 20)
      .fill(LinearGradient(gradient: Gradient(colors: [.light, Color("DarkColor")]), startPoint: .leading, endPoint: .trailing))
    )
  }
  func getTime() {
    Task {
      timeManager.latitude = Float(destination.latitude)
      timeManager.longitude = Float(destination.longitude)
      do {
        try await timeManager.fetchDateTime()
      }
    }
  }
  func getZone() {
    Task {
      timeManager.latitude = Float(destination.latitude)
      timeManager.longitude = Float(destination.longitude)
      do {
        try await timeManager.fetchTimeZone()
      }
    }
  }
  func getDay() {
    Task {
      timeManager.latitude = Float(destination.latitude)
      timeManager.longitude = Float(destination.longitude)
      do {
        try await timeManager.fetchDayOfWeek()
      }
    }
  }
}

#Preview {
  TimeWidgetView(destination: Destination.previewDestination[0], timeResults: TimeResults.timeExample)
}
