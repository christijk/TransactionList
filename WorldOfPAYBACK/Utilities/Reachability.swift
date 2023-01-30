//
//  Reachability.swift
//  WorldOfPAYBACK
//
//  Created by Christi John on 29/01/2023.
//

import Foundation
import Network

final class Reachability {
	static let shared = Reachability()
	private var monitor: NWPathMonitor
	
	private init() {
		monitor = NWPathMonitor()
	}
	
	var isReachable: Bool {
		monitor.currentPath.status == .satisfied
	}
	
	func startNetworkMonitoring() {
		monitor.start(queue: .global(qos: .background))
	}
}
