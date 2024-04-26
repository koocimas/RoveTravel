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

//  override func tearDownWithError() throws {    }
//
//  func testConvertButton() {
//    let convertButton = app.scrollViews.otherElements.buttons["convertButton"]
//    convertButton.tap()
//
//    XCTAssertTrue(convertButton.exists)
//  }
//
//  func testTabButtons() {
//    let tabBar = app.tabBars["Tab Bar"]
//
//    tabBar.buttons["Trip Planner"].tap()
//    XCTAssertTrue(app.tabBars["Trip Planner"].exists)
//
//    tabBar.buttons["Snapshot"].tap()
//    XCTAssertTrue(app.tabBars["Snapshot"].exists)
//  }
//
//  func testamountEntry() {
//    let placeholderValue = 1.00
//    let amountEntered = app.textFields["amountEntered"]
//    if let amount = amountEntered.value as? String,
//       amount.isEmpty == false,
//       amount != amountEntered.placeholderValue {
//      amountEntered.tap()
//      XCTAssert(app.textFields["amountEntered"].exists)
//    }
//  }

//  func testaddItemButton() {
//    let addItemButton = app.collectionViews["Trip Planner"]/*@START_MENU_TOKEN@*/.buttons["Add"]/*[[".cells.buttons[\"Add\"]",".buttons[\"Add\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//      addItemButton.tap()
//    XCTAssert(addItemButton.exists)
//  }

//  func testNavigationBackToMain() throws {
//    let ammanNavBar = app.navigationBars["Amman"]
//      let whereToRoveButton = ammanNavBar.buttons["Where to Rove"]
//      whereToRoveButton.tap()
//
//    XCTAssertFalse(ammanNavBar.exists)
//    XCTAssert(app.navigationBars["Amman"].exists)
//  }

//  func testDestinationsList() throws {
//    let destinationsList = app.scrollViews.otherElements.otherElements["destinationsList"]
//    if destinationsList.waitForExistence(timeout: 5) {
//      XCTAssertTrue(destinationsList.exists)
//    }
//
//    XCTAssertTrue(destinationsList.buttons.element.exists)
//    destinationsList.buttons.element(boundBy: 0).tap()
//
//    let destinationPortal = app.staticTexts["Exchange Rate"]
//    let convert = app.buttons["Convert"]
//    XCTAssertTrue(destinationPortal.exists)
//    XCTAssertTrue(convert.exists)
//  }
}
