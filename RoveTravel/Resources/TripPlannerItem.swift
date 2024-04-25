//
//  TripPlannerItem.swift
//  Rove
//

import Foundation

struct Item: Identifiable, Codable, Hashable {
  let id = UUID()
  var name: String
  var completed: Bool = false
  var notes: String = ""
  var destinationID: String = ""

  enum CodingKeys: String, CodingKey {
    case id = "identifier"
    case name
    case completed = "isCompleted"
    case notes
    case destinationID
  }
}
