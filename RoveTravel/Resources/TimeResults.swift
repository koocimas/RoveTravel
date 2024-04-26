//
//  TimeResults.swift
//  Rove
//
//  Created by Sam Cook on 4/22/24.
//

import Foundation

struct TimeResults: Codable {
  var year, month, day, hour: Int
  var minute, seconds, milliSeconds: Int
  var dateTime, date, time, timeZone: String
  var dayOfWeek: String
  var dstActive: Bool
}

extension TimeResults {
  static var timeExample: TimeResults {
    TimeResults(
      year: 2024,
      month: 01,
      day: 01,
      hour: 01,
      minute: 01,
      seconds: 01,
      milliSeconds: 01,
      dateTime: "2024-01-01T01:01:01.01",
      date: "0/1/01/2024",
      time: "01:01",
      timeZone: "America/New York",
      dayOfWeek: "Monday",
      dstActive: true)
  }
}
func timeIn12HourFormat(from date: Date) -> String {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "h:mm a"
  dateFormatter.amSymbol = "AM"
  dateFormatter.pmSymbol = "PM"
  return dateFormatter.string(from: date)
}
func dateFormatTime(date: String) -> Date {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSS"
  return dateFormatter.date(from: date) ?? Date.now
}
