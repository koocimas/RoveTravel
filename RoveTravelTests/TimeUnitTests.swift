//
//  TimeUnitTests.swift
//  TimeUnitTests
//
//  Created by Sam Cook on 4/25/24.
//

@testable import RoveTravel
import XCTest

final class TimeUnitTests: XCTestCase {
  var timeViewModel: TimeManager?

  override func setUpWithError() throws {
    timeViewModel = TimeManager()
  }

  override func tearDownWithError() throws {
    timeViewModel = nil
  }

  @MainActor
  func test_dateTime_notEmpty() async {
    guard let viewModel = timeViewModel else { return }

    let dateTimeLoaded = expectation(description: "date and time should be loading")
    defer { waitForExpectations(timeout: 2) }

    await viewModel.fetchDateTime()

    dateTimeLoaded.fulfill()

    let dateTime = viewModel.dateTime

    XCTAssertTrue(!dateTime.isEmpty)
  }

  @MainActor
  func test_timeZone_notEmpty() async {
    guard let viewModel = timeViewModel else { return }

    let timeZoneLoaded = expectation(description: "time zone should be loading")
    defer { waitForExpectations(timeout: 2) }

    await viewModel.fetchTimeZone()

    timeZoneLoaded.fulfill()

    let timeZone = viewModel.timeZone

    XCTAssertTrue(!timeZone.isEmpty)
  }

  @MainActor
  func test_dayOfWeek_notEmpty() async {
    guard let viewModel = timeViewModel else { return }

    let dayOfWeekLoaded = expectation(description: "weekday should be loading")
    defer { waitForExpectations(timeout: 2) }

    await viewModel.fetchDayOfWeek()

    dayOfWeekLoaded.fulfill()

    let dayOfWeek = viewModel.dayOfWeek

    XCTAssertTrue(!dayOfWeek.isEmpty)
  }
}
