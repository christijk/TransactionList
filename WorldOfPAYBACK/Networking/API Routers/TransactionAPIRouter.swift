//
//  TransactionAPIRouter.swift
//  WorldOfPAYBACK
//
//  Created by Christi John on 27/01/2023.
//

import Foundation

// MARK: Enum for transaction list api calls

enum TransactionAPIRouter {
	private struct Path {
		static let transactionList = "/transactions"
	}
	
	case transactionList
	
	var path: String {
		switch self {
			case .transactionList:
				return Path.transactionList
		}
	}
}

// MARK: - APIRouter Protocol requirements

extension TransactionAPIRouter: APIRouter {
	var requestURL: URL {
		switch self {
			case .transactionList:
				return Environment.BASE_URL.appendingPathComponent(path)
		}
	}
	
	var method: HTTPMethod {
		switch self {
			case .transactionList:
				return .get
		}
	}
	
	var headers: [String : String]? {
		return nil
	}
	
	var parameters: Parameters? {
		return nil
	}
}
