//
//  TripPlannerItem.swift
//  Rove
//

import Foundation
import SwiftUI

struct Item: Identifiable, Codable, Hashable {
  let id = UUID()
  var name: String
  var completed: Bool = false
  var notes: String = ""
  var destinationID: String = ""
  var photos: [Data?]

  enum CodingKeys: String, CodingKey {
    case id = "identifier"
    case name
    case completed = "isCompleted"
    case notes
    case destinationID
    case photos
  }

  static func example() -> Item {
    Item(
      name: "Visit Petra",
      completed: false,
      notes: "Bring water and sunblock",
      destinationID: "Amman",
      photos: []
    )
  }
 }
