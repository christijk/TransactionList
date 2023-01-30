//
//  TransactionDetailViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Christi John on 29/01/2023.
//

import Foundation
import Combine

class TransactionDetailViewModel: ObservableObject {
	@Published var partnerDisplayName: String
	@Published var transactionDesc: String
	
	init(partnerDisplayName: String, transactionDesc: String) {
		self.partnerDisplayName = partnerDisplayName
		self.transactionDesc = transactionDesc
	}
	
}
