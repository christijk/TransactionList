//
//  NibRepresentable.swift
//  WorldOfPAYBACK
//
//  Created by Christi John on 27/01/2023.
//

import Foundation
import UIKit

// Protocol to use Nib name as Cell Identifier
//
protocol NibRepresentable {
	static var nib: UINib { get }
	static var identifier: String { get }
}

extension UIView: NibRepresentable {
	class var nib: UINib {
		return UINib(nibName: identifier, bundle: nil)
	}
	
	class var identifier: String {
		return String(describing: self)
	}
}
