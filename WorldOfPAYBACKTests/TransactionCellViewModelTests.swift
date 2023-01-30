//
//  TransactionCellViewModelTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Christi John on 29/01/2023.
//

import XCTest
@testable import WorldOfPAYBACK

final class TransactionCellViewModelTests: XCTestCase {

	var sut: TransactionCellViewModel!
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		sut = TransactionCellViewModel(transaction: item)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testDateFormattedExists() {
		if let date = sut.dateFormatted {
			XCTAssertFalse(date.isEmpty)
		} else {
			XCTFail("Failed to fetch date")
		}
	}
	
	func testPartnerName() {
		XCTAssertNotNil(sut.partnerName)
		
		let partnerName = "REWEGroup"
		XCTAssertEqual(sut.partnerName, partnerName)
	}
	
	func testTransactionDesc() {
		XCTAssertNotNil(sut.transactionDesc)
		
		let desc = "Punktesammeln"
		XCTAssertEqual(sut.transactionDesc, desc)
	}
	
	func testAmountWithCurrency() {
		XCTAssertNotNil(sut.amountWithCurrency)
		
		let amount = "PBP 124.00" 
		XCTAssertEqual(sut.amountWithCurrency, amount)
	}
}

extension TransactionCellViewModelTests {
	var item: Items {
		TransactionRequestHandlerMock().getTranasctions()?.items?.first ?? Items()
	}
}
