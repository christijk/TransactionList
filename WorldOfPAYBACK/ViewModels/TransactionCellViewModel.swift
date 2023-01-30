//
//  TransactionCellViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Christi John on 27/01/2023.
//

import Foundation

protocol TransactionCellDisplayable {
	var dateFormatted: String? { get }
	var partnerName: String? { get }
	var transactionDesc: String? { get }
	var amountWithCurrency: String? { get }
}

class TransactionCellViewModel {
	private(set) var transaction: Items?
	
	init(transaction: Items) {
		self.transaction = transaction
	}
}

extension TransactionCellViewModel: TransactionCellDisplayable, DateFormatterProtocol {
	var dateFormatted: String? {
		formatDate(transaction?.transactionDetail?.bookingDate)
	}
	
	var partnerName: String? {
		transaction?.partnerDisplayName
	}
	
	var transactionDesc: String? {
		transaction?.transactionDetail?.description
	}
	
	var amountWithCurrency: String? {
		guard let amount = transaction?.transactionDetail?.value?.amount,
			  let currency = transaction?.transactionDetail?.value?.currency else {
			return nil
		}
		let formattedAmount = Double(amount)
		return formattedAmount.formatted(.currency(code: currency))
	}
	
	
}
