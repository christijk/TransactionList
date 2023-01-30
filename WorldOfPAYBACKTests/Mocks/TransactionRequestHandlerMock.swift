//
//  TransactionRequestHandlerMock.swift
//  WorldOfPAYBACKTests
//
//  Created by Christi John on 29/01/2023.
//

import Foundation
import Combine
@testable import WorldOfPAYBACK

final class TransactionRequestHandlerMock {
	
	func getTranasctions() -> Transactions? {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		
		do {
			let items = try decoder.decode(Transactions.self, from: self.JSON.data(using: .utf8)!)
			return items
		} catch _ {
			return nil
		}
	}
}

extension TransactionRequestHandlerMock {
	var JSON: String {  "{\"items\":[{\"partnerDisplayName\":\"REWEGroup\",\"alias\":{\"reference\":\"795357452000810\"},\"category\":1,\"transactionDetail\":{\"description\":\"Punktesammeln\",\"bookingDate\":\"2022-07-24T10:59:05+0200\",\"value\":{\"amount\":124,\"currency\":\"PBP\"}}},{\"partnerDisplayName\":\"dm-dogeriemarkt\",\"alias\":{\"reference\":\"098193809705561\"},\"category\":1,\"transactionDetail\":{\"description\":\"Punktesammeln\",\"bookingDate\":\"2022-06-23T10:59:05+0200\",\"value\":{\"amount\":1240,\"currency\":\"PBP\"}}},{\"partnerDisplayName\":\"OTTOGroup\",\"alias\":{\"reference\":\"094844835601044\"},\"category\":2,\"transactionDetail\":{\"bookingDate\":\"2022-08-22T10:59:05+0200\",\"value\":{\"amount\":53,\"currency\":\"PBP\"}}}]}"
	}
}
