//
//  TransactionDetailsView.swift
//  WorldOfPAYBACK
//
//  Created by Christi John on 29/01/2023.
//

import SwiftUI
import Combine

struct TransactionDetailsView: View {
	private struct Constants {
		static let title = "Details"
	}
	
	@ObservedObject var viewModel: TransactionDetailViewModel
	
    var body: some View {
		NavigationView {
			VStack(spacing: 8) {
				Text(viewModel.partnerDisplayName)
					.font(.system(size: 18, weight: .semibold))
					.accessibility(identifier: "partnerDisplayName")
				Text(viewModel.transactionDesc)
					.font(.system(size: 15, weight: .regular))
					.accessibility(identifier: "transactionDesc")
			}
		}.navigationTitle(Constants.title.localized())
		
    }
}

struct TransactionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
		TransactionDetailsView(viewModel: TransactionDetailViewModel(partnerDisplayName: "Test Partner Name", transactionDesc: "Test Partner Description"))
    }
}
