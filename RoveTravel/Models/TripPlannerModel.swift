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
//  var tag = [Tag]()
  var photos: [Data?]

  enum Tag: String, CaseIterable, Codable, Hashable {
    case foodDrink = "Food/Drink"
    case touristAttraction = "Tourist Attraction"
    case historicalMonument = "Historical Monument"
    case viewscenery = "Views/Scenery"
    case toDo = "To-Do"
    case transportation = "Transportation"
    case museum = "Museum"
    case guidedTour = "Guided Tour"
    var name: String { rawValue }
  }

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
//      tag: [],
      photos: []
    )
  }
 }
