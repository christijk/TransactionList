//
//  PBError.swift
//  WorldOfPAYBACK
//
//  Created by Christi John on 27/01/2023.
//

import Foundation

enum PBError: Error {
	case parameterEncodingFailed
	case invalidURL
	case noInternet
	case decodingError(String)
	case genericError(String?)
	case invalidResponseCode(Int)
	case randomFailure
	
	var title: String {
		switch self {
			case .parameterEncodingFailed:
				return "Encoding Failed"
			case .invalidURL:
				return "Invalid URL"
			case .noInternet:
				return "You're offline!"
			case .decodingError:
				return "Encountered an error while decoding response"
			case .genericError:
				return "Something went wrong"
			case .invalidResponseCode(let code):
				return "Server retuned \(code) status code"
			case .randomFailure:
				return "Something went wrong"
		}
	}
	
	var errorDescription: String {
		switch self {
			case .parameterEncodingFailed:
				return "Request parameter encoding failed"
			case .invalidURL:
				return "Unable to create request URL"
			case .noInternet:
				return "Please check your internet connection."
			case .decodingError(let message):
				return message
			case .genericError(let message):
				return message ?? ""
			case .randomFailure:
				return "This is one of the random failures, Please try again"
			default:
				return "Something went wrong!"
		}
	}
}
