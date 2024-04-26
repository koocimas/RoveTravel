//
//  TimeWidgetView.swift
//  Rove
//

import SwiftUI

struct TimeWidgetView: View {
  @ObservedObject var timeManager = TimeManager()
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
      .fill(LinearGradient(
        gradient: Gradient(colors: [.light, Color("DarkColor")]),
        startPoint: .leading,
        endPoint: .trailing))
    )
  }
  func getTime() {
    Task {
      timeManager.latitude = Float(destination.latitude)
      timeManager.longitude = Float(destination.longitude)
      do {
        await timeManager.fetchDateTime()
      }
    }
  }
  func getZone() {
    Task {
      timeManager.latitude = Float(destination.latitude)
      timeManager.longitude = Float(destination.longitude)
      do {
        await timeManager.fetchTimeZone()
      }
    }
  }
  func getDay() {
    Task {
      timeManager.latitude = Float(destination.latitude)
      timeManager.longitude = Float(destination.longitude)
      do {
        await timeManager.fetchDayOfWeek()
      }
    }
  }
}

#Preview {
  TimeWidgetView(timeResults: TimeResults.timeExample, destination: Destination.previewDestination[0])
}
