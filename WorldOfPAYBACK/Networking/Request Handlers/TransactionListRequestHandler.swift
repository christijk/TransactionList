//
//  TransactionListRequestHandler.swift
//  WorldOfPAYBACK
//
//  Created by Christi John on 27/01/2023.
//

import Foundation
import Combine

protocol TransactionListRequestProtocol {
	func getTranasctions(router: APIRouter, shouldFail: Bool) -> Future<Transactions?, PBError>
	func getTranasctionsFromServer(router: APIRouter) async throws -> Result<Transactions, PBError>
}

final class TransactionListRequestHandler: TransactionListRequestProtocol {
	var subscriptions = Set<AnyCancellable>()
	
	/// Method to get all the transaction data
	///
	/// - Parameter router: API route with required information
	/// - Parameter shouldFail: Boolen to make the request failed
	/// - returns Future: With API result, either Transaction Object or PBError
	///
	func getTranasctions(router: APIRouter, shouldFail: Bool) -> Future<Transactions?, PBError> {
		Future { promise in
			guard Reachability.shared.isReachable else {
				promise(.failure(.noInternet))
				return
			}
			
			guard let url = Bundle.main.url(forResource: "PBTransactions", withExtension: "json") else {
				promise(.failure(.genericError("File not found in bundle")))
				return
			}
			
			guard let data = try? Data(contentsOf: url) else {
				promise(.failure(.genericError("File loading failed")))
				return
			}
			
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			
			do {
				let items = try decoder.decode(Transactions.self, from: data)
				DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
					shouldFail ?
					promise(.failure(.randomFailure)) :
					promise(.success(items))
				}
			} catch let error {
				promise(.failure(.decodingError(error.localizedDescription.debugDescription)))
			}
		}
	}
	
	
	
	func getTranasctionsFromServer(router: APIRouter) async throws -> Result<Transactions, PBError> {
		return try await NetworkManager.request(route: router, model: Transactions.self)
	}
}
