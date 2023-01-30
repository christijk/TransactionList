//
//  Transactions.swift
//  WorldOfPAYBACK
//
//  Created by Christi John on 27/01/2023.
//

import Foundation

struct Transactions: Codable {
	var items: [Items]?
}

struct Items: Codable {
	var partnerDisplayName: String?
	var category: Int?
	var transactionDetail: TransactionDetail?
}

struct TransactionDetail: Codable,DateFormatterProtocol {
	var description: String?
	var value: Value?
	var bookingDate: String?
	var bookingDateObject: Date? {
		getDate(bookingDate)
	}
}

struct Value: Codable {
	var amount: Double?
	var currency: String?
}

