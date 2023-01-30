//
//  Constants.swift
//  WorldOfPAYBACK
//
//  Created by Christi John on 27/01/2023.
//

import Foundation

// MARK: Type Aliases: Named Closures, Params dict etc.
//
typealias Parameters = [String: Any]
typealias NetworkCompletion<T> = (Result<T, PBError>) -> Void

// MARK: HTTP Methods
//
enum HTTPMethod: String {
	case get    = "GET"
	case post   = "POST"
	case patch  = "PATCH"
	case put    = "PUT"
}

// MARK: Constants required for the app
//
struct Constants {
	static let contentType 		= "Content-Type"
	static let contentTypeJson 	= "application/json"
}
