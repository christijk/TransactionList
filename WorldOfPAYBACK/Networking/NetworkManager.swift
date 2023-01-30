//
//  NetworkManager.swift
//  WorldOfPAYBACK
//
//  Created by Christi John on 27/01/2023.
//

import Foundation
import Combine

final class NetworkManager {
	/// Generic method which is used to make api request to fetch data from server
	///
	/// - Parameter route: Any api's which conforms to APIRouter protocol
	/// - returns Result: Result which holds the api result,
	///                     either Model object or error
	///
	static func request<T: Decodable>(route: APIRouter,
									  model: T.Type) async throws -> Result<T, PBError> {
		let request = route.asURLRequest()
		
		let (data, response) = try await URLSession.shared.data(for: request)
		
		if let httpResponse = response as? HTTPURLResponse {
			guard 200...299 ~= httpResponse.statusCode else {
				return .failure(.invalidResponseCode(httpResponse.statusCode))
			}
		}
		
		do {
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			let model = try decoder.decode(model, from: data)
			return .success(model)
		} catch let error {
			if let decodingError = error as? DecodingError {
				return .failure(PBError.decodingError((decodingError as NSError).debugDescription))
			}
			return .failure(PBError.genericError(error.localizedDescription))
		}
	}
}
