//
//  TransactionViewControllerTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Christi John on 30/01/2023.
//

import XCTest
import Combine
@testable import WorldOfPAYBACK

final class TransactionViewControllerTests: XCTestCase {

	var sut: TransactionViewController!
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		sut = storyboard.instantiateViewController(withIdentifier: "kTransactionViewController") as? TransactionViewController
		sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testConfigureUI() {
		sut.configureUI()
		XCTAssertEqual(sut.title, "Transactions")
	}
	
	func testBindViewModel() {
		sut.bindViewModel()
		XCTAssertNotNil(sut.viewModel)
	}
	
	func testAPICallStart() {
		sut.bindViewModel()
		XCTAssertTrue(sut.activityIndicator.isAnimating)
	}
	
	func testNumberOfRows() {
		let transactions = TransactionRequestHandlerMock().getTranasctions()?.items
		sut.viewModel?.createCellModels(transactions)
	
		let cells = sut.tableView.numberOfRows(inSection: 0)
		XCTAssertEqual(cells, 3)
	}
}
