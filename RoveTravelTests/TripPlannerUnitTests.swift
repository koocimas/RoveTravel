//
//  TripPlannerUnitTests.swift
//  RoveTravelTests
//
//  Created by Sam Cook on 4/25/24.
//

@testable import RoveTravel
import XCTest

final class TripPlannerUnitTests: XCTestCase {
  var tripPlannerViewModel: TripPlannerManager?

  override func setUpWithError() throws {
    tripPlannerViewModel = TripPlannerManager()
  }

  override func tearDownWithError() throws {
    tripPlannerViewModel = nil
  }

  @MainActor
  func test_addItem() {
    guard let viewModel = tripPlannerViewModel else { return }

    let count = viewModel.items.count

    viewModel.addNewItem(name: "Visit Petra", destinationID: "Amman")

    XCTAssertEqual(viewModel.items.count, count + 1)
  }
}
