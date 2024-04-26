//
//  RoveTravelUITests.swift
//  RoveTravelUITests
//
//  Created by Sam Cook on 4/25/24.
//

import XCTest

final class RoveTravelUITests: XCTestCase {
  var app: XCUIApplication!
  override func setUpWithError() throws {
    app = XCUIApplication()
    app.launch()
    continueAfterFailure = false
  }
  func testNewsList() throws {
    let newsList = app.scrollViews.otherElements.otherElements["newsList"]
    if newsList.waitForExistence(timeout: 5) {
      XCTAssertTrue(newsList.exists)
    }
  }
  override func tearDownWithError() throws {
  }
  func testDestinationButton() {
    let destinationButton = app.buttons["Amman, Jordan"]
    destinationButton.tap()
    XCTAssertTrue(destinationButton.exists)
  }
}
