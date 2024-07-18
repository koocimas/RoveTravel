//
//  TimeWidgetViewModel.swift
//  RoveTravel
//

import Foundation

class TimeWidgetViewModel: ObservableObject {
    private let destination: Destination
    private let timeManager: TimeManager

    init(destination: Destination, timeManager: TimeManager = .shared) {
        self.destination = destination
        self.timeManager = timeManager

        fetchTimeStuff()
    }

    var dayOfWeekAndDate: String {
        return "\(timeManager.dayOfWeek), \(fullDate(from: dateFormatTime(date: timeManager.dateTime)))"
    }

    var destinationTime: String {
        timeIn12HourFormat(from: dateFormatTime(date: "\(timeManager.dateTime)"))
    }

    var destinationTimeZone: String {
        "Timezone: \(timeManager.timeZone)"
    }

    func fetchTimeStuff() {
    Task {
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
            objectWillChange.send()
        }
    }
}

// export localizations?

// swiftlint:disable:next line_length
// time managing protocol - dependency injection / better for testing, pass the time manager of type time managing = timeManager.shared - add protocols in time manager file at the top, mock stub that conforms to time managing protocol to inject at testing and for previews
