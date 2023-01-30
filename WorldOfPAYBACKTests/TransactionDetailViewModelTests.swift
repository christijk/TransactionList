//
//  TransactionDetailViewModelTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Christi John on 29/01/2023.
//

import XCTest
import Combine
@testable import WorldOfPAYBACK

final class TransactionDetailViewModelTests: XCTestCase {

	var sut: TransactionDetailViewModel!
	var subscriptions = Set<AnyCancellable>()
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		sut = TransactionDetailViewModel(partnerDisplayName: "REWEGroup",
										 transactionDesc: "Punktesammeln")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testPartnerDisplayNameExists() {
		XCTAssertFalse(sut.partnerDisplayName.isEmpty)
	}
	
	func testTransactionDescExists() {
		XCTAssertFalse(sut.transactionDesc.isEmpty)
	}
	
	func testPartnerDisplayNameValue() {
		sut.$partnerDisplayName.sink { value in
			XCTAssertEqual(value, "REWEGroup")
		}.store(in: &subscriptions)
	}
	
	func testTransactionDescValue() {
		sut.$transactionDesc.sink { value in
			XCTAssertEqual(value, "Punktesammeln")
		}.store(in: &subscriptions)
	}
	
	func testPartnerDisplayNameEmpty() {
		sut = TransactionDetailViewModel(partnerDisplayName: "",
										 transactionDesc: "Punktesammeln")
		sut.$partnerDisplayName.sink { value in
			XCTAssertTrue(value.isEmpty)
		}.store(in: &subscriptions)
	}
	
	func testTransactionDescEmpty() {
		sut = TransactionDetailViewModel(partnerDisplayName: "REWEGroup",
										 transactionDesc: "")
		sut.$transactionDesc.sink { value in
			XCTAssertTrue(value.isEmpty)
		}.store(in: &subscriptions)
	}
}
