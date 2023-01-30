//
//  WorldOfPAYBACKUITests.swift
//  WorldOfPAYBACKUITests
//
//  Created by Christi John on 27/01/2023.
//

import XCTest

final class WorldOfPAYBACKUITests: XCTestCase {

	let app = XCUIApplication()
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
		app.launch()
		
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testTransactionTableLoading() {
		sleep(3) // Wait for the api call
		XCTAssertGreaterThan(app.tables["TransactionTable"].cells.count, 1)
	}
	
	func testTransactionTableCell() {
		sleep(3)
		let table = app.tables["TransactionTable"]
		let cell = table.children(matching: .cell).element(boundBy: 0)
		XCTAssertTrue(cell.staticTexts["dateLabel"].exists)
		XCTAssertTrue(cell.staticTexts["partnerNameLabel"].exists)
		XCTAssertTrue(cell.staticTexts["descLabel"].exists)
		XCTAssertTrue(cell.staticTexts["amountLabel"].exists)
	}
	
	func testDetailScreenLoading() {
		sleep(3) // Wait for the api call
		
		let table = app.tables["TransactionTable"]
		table.children(matching: .cell).element(boundBy: 0).tap()
		XCTAssertTrue(app.navigationBars["Details"].exists)
	}
	
	func testDetailView() {
		sleep(3)
		let table = app.tables["TransactionTable"]
		table.children(matching: .cell).element(boundBy: 0).tap()
		XCTAssertTrue(app.staticTexts["partnerDisplayName"].exists)
		XCTAssertTrue(app.staticTexts["transactionDesc"].exists)
	}
	
	func testNavigationBack() {
		sleep(3)
		let table = app.tables["TransactionTable"]
		table.children(matching: .cell).element(boundBy: 0).tap()
		app.navigationBars["Details"].buttons["Transactions"].tap()
		let listVC = app.otherElements["transactionsVC"]
		let vcShown = listVC.waitForExistence(timeout: 5)
		XCTAssert(vcShown)
		
	}
}
