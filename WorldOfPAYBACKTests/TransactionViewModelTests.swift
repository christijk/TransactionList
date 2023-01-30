//
//  TransactionViewModelTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Christi John on 29/01/2023.
//

import XCTest
import Combine
@testable import WorldOfPAYBACK

final class TransactionViewModelTests: XCTestCase {

	var sut: TransactionViewModel!
	var subscriptions = Set<AnyCancellable>()
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		sut = TransactionViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testCreateCellModels() {
		XCTAssertEqual(sut.numberOfRows, 0)
		
		sut.createCellModels(transaction?.items)
		XCTAssertEqual(sut.numberOfRows, 3)
	}

	func testGetCellModel() {
		XCTAssertNil(sut.getCellModel(for: 0))
		
		sut.createCellModels(transaction?.items)
		XCTAssertNotNil(sut.getCellModel(for: 0))
	}
	
	func testGetDetailModel() {
		sut.createCellModels(transaction?.items)
		
		XCTAssertNotNil(sut.getDetailModel(for: 0))
		XCTAssertNil(sut.getCellModel(for: 1000))
	}
	
	func testGetFilters() {
		XCTAssertNil(sut.filters)
		
		sut.getFilters(transaction?.items)
		XCTAssertNotNil(sut.filters)
		XCTAssertEqual(sut.filters?.count, 2)
	}
	
	func testFilterTransactionsWithValidCategory() {
		let sorted = sut.getSortedTransactions(transaction)
		XCTAssertNotNil(sorted)
		
		var category = 1
		sut.filterTransactions(for: category)
		XCTAssertEqual(sut.transactionCellVMs?.count, 2)
		
		category = 2
		sut.filterTransactions(for: category)
		XCTAssertEqual(sut.transactionCellVMs?.count, 1)
		
		category = 3
		sut.filterTransactions(for: category)
		XCTAssertEqual(sut.transactionCellVMs?.count, 0)
	}
	
	func testFilterTransactionsWithInvalidCategory() {
		let sorted = sut.getSortedTransactions(transaction)
		XCTAssertNotNil(sorted)
		
		let category = 999
		sut.filterTransactions(for: category)
		XCTAssertEqual(sut.transactionCellVMs?.count, 0)
	}
	
	func testFilterTransactionsWithEmptyCategory() {
		let sorted = sut.getSortedTransactions(transaction)
		XCTAssertNotNil(sorted)
		
		sut.filterTransactions(for: nil)
		XCTAssertEqual(sut.transactionCellVMs?.count, 0)
	}
	
	func testClearFilters() {
		let sorted = sut.getSortedTransactions(transaction)
		sut.createCellModels(sorted)
		XCTAssertEqual(sut.transactionCellVMs?.count, 3)
		
		let category = 2
		sut.filterTransactions(for: category)
		XCTAssertEqual(sut.transactionCellVMs?.count, 1)
		
		sut.clearFilters()
		XCTAssertEqual(sut.transactionCellVMs?.count, 3)
	}
	
	func testCalculateTotal() {
		let sorted = sut.getSortedTransactions(transaction)
		let total = "PBP 1,417.00"
		
		sut.calculateTotal(sorted)
		XCTAssertEqual(sut.total, total)
	}
	
	func testCalculateTotalWithFilters() {
		let sorted = sut.getSortedTransactions(transaction)
		var total = "PBP 1,417.00"
		sut.calculateTotal(sorted)
		
		total = "PBP 53.00"
		let category = 2
		let filtered = sut.filterTransactions(for: category)
		
		sut.calculateTotal(filtered)
		XCTAssertEqual(sut.total, total)
	}
	
	func testGetSortedTransactions() {
		var first = transaction?.items?.first?.transactionDetail?.bookingDateObject ?? .now
		var last = transaction?.items?.last?.transactionDetail?.bookingDateObject ?? .now
		XCTAssertLessThan(first, last)
		
		let sorted = sut.getSortedTransactions(transaction)
		first = sorted?.first?.transactionDetail?.bookingDateObject ?? .now
		last = sorted?.last?.transactionDetail?.bookingDateObject ?? .now
		XCTAssertGreaterThan(first, last)
	}
	
	func testGetTransactionsAPISuccess() {
		let expectation = self.expectation(description: "Transaction list fetching success")
		sut.$loading.sink { [weak self] status in
			guard status == false else { return }
			XCTAssertEqual(status, false)
			XCTAssertNil(self?.sut.error.0)
			XCTAssertNil(self?.sut.error.1)
			expectation.fulfill()
		}.store(in: &subscriptions)
		
		sut.getTransactions(shouldFail: false)
		wait(for: [expectation], timeout: 3.0)
	}
	
	func testGetTransactionsAPIFailure() {
		let expectation = self.expectation(description: "Transaction list fetching failure")
		sut.$error.sink { [weak self] (errorTitle, errorSubTitle) in
			guard self?.sut.loading == false else { return }
			XCTAssertNotNil(errorTitle)
			XCTAssertNotNil(errorSubTitle)
			expectation.fulfill()
		}.store(in: &subscriptions)
		
		sut.getTransactions(shouldFail: true)
		wait(for: [expectation], timeout: 3.0)
	}
}

extension TransactionViewModelTests {
	var transaction: Transactions? {
		TransactionRequestHandlerMock().getTranasctions()
	}
}
