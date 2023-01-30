//
//  Environment.swift
//  WorldOfPAYBACK
//
//  Created by Christi John on 30/01/2023.
//

import Foundation

struct Environment {
	private enum EnvKeys: String {
		case baseURL = "BASE_URL"
	}
	
	private static let infoDictionary: [String: Any] = {
		guard let dict = Bundle.main.infoDictionary else {
			fatalError("Plist not found")
		}
		return dict
	}()
	
	static let BASE_URL: URL = {
		guard let baseURL = Environment.infoDictionary[EnvKeys.baseURL.rawValue] as? String else {
			fatalError("Base URL not set in plist")
		}
		guard let url = URL(string: baseURL) else {
			fatalError("Base URL is invalid")
		}
		return url
	}()	
}
