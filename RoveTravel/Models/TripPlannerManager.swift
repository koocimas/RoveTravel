//
//  TripPlannerManager.swift
//  Rove
//

import Foundation
import Combine

class TripPlannerManager: ObservableObject {
  let tpJSONURL = URL(fileURLWithPath: "CategorizedItems",
                      relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
  @Published var id = UUID()
  @Published var addingItem = false
  @Published var items: [Item] = [] {
    didSet {
      saveJSONCategorizedItems()
    }
  }

  func addNewItem(name: String, destinationID: String) {
    items.append(Item(name: name, destinationID: destinationID))
  }
  func toggleItemCompletion(item: Item) {
    if let index = items.firstIndex(where: { $0.id == item.id }) {
      items[index].completed.toggle()
    }
  }

  init() {
    loadJSONCategorizedItems()
    print(URL.documentsDirectory.path)
  }

  private func loadJSONCategorizedItems() {
    guard FileManager.default.fileExists(atPath: tpJSONURL.path) else {
      return
    }

    let decoder = JSONDecoder()

    do {
      let tpData = try Data(contentsOf: tpJSONURL)
      items = try decoder.decode([Item].self, from: tpData)
    } catch let error {
      print(error)
    }
  }

  private func saveJSONCategorizedItems() {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted

    do {
      let tpData = try encoder.encode(items)

      try tpData.write(to: tpJSONURL, options: .atomicWrite)
    } catch let error {
      print(error)
    }
  }
}
extension TripPlannerManager: Identifiable, Hashable  {
    var identifier: String {
            return UUID().uuidString
        }
    public func hash(into hasher: inout Hasher) {
            return hasher.combine(identifier)
        }
    static func == (lhs: TripPlannerManager, rhs: TripPlannerManager) -> Bool {
        if lhs.items == rhs.items && lhs.addingItem == rhs.addingItem {
        }
        return true
    }
}
