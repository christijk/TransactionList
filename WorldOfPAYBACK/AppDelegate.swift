//
//  AppDelegate.swift
//  WorldOfPAYBACK
//
//  Created by Christi John on 27/01/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	func application(_ application: UIApplication, didFinishLaunchingWithOptions
					 launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Start network monitoring
		//
		Reachability.shared.startNetworkMonitoring()
		
		return true
	}
}

