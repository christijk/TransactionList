//
//  DateFormatter.swift
//  WorldOfPAYBACK
//
//  Created by Christi John on 27/01/2023.
//

import Foundation

protocol DateFormatterProtocol { }

extension DateFormatterProtocol {
	func formatDate(_ date: String?) -> String? {
		guard let date = date else { return nil }
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
		guard let outputDate = dateFormatter.date(from: date) else {
			return nil
		}
		dateFormatter.setLocalizedDateFormatFromTemplate("MMM d yyyy, h:mm a")
		return dateFormatter.string(from: outputDate)
	}
	
	func getDate(_ date: String?) -> Date? {
		guard let date = date else { return nil }
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
		guard let outputDate = dateFormatter.date(from: date) else {
			return nil
		}
		return outputDate
	}
}
