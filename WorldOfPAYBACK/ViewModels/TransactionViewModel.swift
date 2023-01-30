//
//  TransactionViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Christi John on 27/01/2023.
//

import Foundation
import Combine

protocol TransactionViewModelProtocol {
	var numberOfRows: Int { get }
	func getTransactions(shouldFail: Bool)
	func getCellModel(for indexPath: Int) -> TransactionCellViewModel?
	func getDetailModel(for indexPath: Int) -> TransactionDetailViewModel?
	func filterTransactions(for category: Int?) -> [Items]?
	func clearFilters()
}

class TransactionViewModel: TransactionViewModelProtocol, DateFormatterProtocol {

	@Published var error: (String?, String?)
	@Published var loading: Bool = true
	@Published var total: String?
	let onTransactionAPISuccess = PassthroughSubject<Void, Never>()
	let onRandomAPIError = PassthroughSubject<(String, String), Never>()
	var subscriptions = Set<AnyCancellable>()
	
	var requestHandler: TransactionListRequestProtocol
	private(set) var filters: [Int]?
	private(set) var transaction: [Items]?
	private(set) var transactionCellVMs: [TransactionCellViewModel]? {
		didSet {
			onTransactionAPISuccess.send()
		}
	}
	
	var numberOfRows: Int {
		transactionCellVMs?.count ?? 0
	}
	
	init(requestHandler: TransactionListRequestProtocol = TransactionListRequestHandler()) {
		self.requestHandler = requestHandler
		transactionCellVMs = []
	}
	
	/// Method to fetch the transaction data
	/// - parameter shouldFail: Boolean to enable the request failure
	///
	func getTransactions(shouldFail: Bool) {
		loading = true
		let router = TransactionAPIRouter.transactionList
		requestHandler.getTranasctions(router: router, shouldFail: shouldFail)
			.sink { [weak self] completion in
				switch completion {
					case .finished:
						self?.loading = false
					case .failure(let error):
						self?.loading = false
						switch error {
							case .randomFailure:
								self?.onRandomAPIError.send((error.title, error.errorDescription))
							default:
								self?.error = (error.title, error.errorDescription)
						}
				}
			} receiveValue: { [weak self] value in
				let sorted = self?.getSortedTransactions(value)
				self?.createCellModels(sorted)
				self?.getFilters(sorted)
				self?.calculateTotal(sorted)
			}
			.store(in: &subscriptions)
	}
	
	/// Method to create View Models for cell
	/// - parameter transaction: List of transactions
	///
	func createCellModels(_ transaction: [Items]?) {
		transactionCellVMs = transaction?.map { TransactionCellViewModel(transaction: $0) }
	}
	
	/// Method to return View Models for visible row
	/// - parameter indexPath: visible row index
	/// - returns TransactionCellViewModel
	///
	func getCellModel(for indexPath: Int) -> TransactionCellViewModel? {
		transactionCellVMs?[safe: indexPath]
	}
	
	/// Method to return View Models for selected row
	/// - parameter indexPath: selected row index
	/// - returns TransactionDetailViewModel
	///
	func getDetailModel(for indexPath: Int) -> TransactionDetailViewModel? {
		let item = transactionCellVMs?[safe: indexPath]?.transaction
		return TransactionDetailViewModel(partnerDisplayName: item?.partnerDisplayName ?? "",
										  transactionDesc: item?.transactionDetail?.description ?? "")
	}
	
	/// Method to generate available filters
	/// - parameter transaction: List of transactions
	///
	func getFilters(_ transaction: [Items]?) {
		self.filters = Array(Set(transaction?.compactMap { $0.category } ?? [])).sorted(by: <)
	}
	
	/// Method to filter transaction based on selected category
	/// - parameter category: Selected category info
	/// - returns [Items]
	///
	@discardableResult
	func filterTransactions(for category: Int?) -> [Items]? {
		guard let category = category else { return nil }
		let filtered = self.transaction?.filter { $0.category == category }
		createCellModels(filtered)
		calculateTotal(filtered)
		return filtered
	}
	
	/// Method to clear filter and reset data
	///
	func clearFilters() {
		createCellModels(transaction)
		calculateTotal(transaction)
	}
	
	/// Method to calculate total value of transactions
	/// - parameter items: List of transactions
	///
	func calculateTotal(_ items: [Items]?) {
		let sum = items?.reduce(0) { ($0 + ($1.transactionDetail?.value?.amount ?? 0))}
		let currency = items?.first?.transactionDetail?.value?.currency ?? ""
		total = sum?.formatted(.currency(code: currency))
	}
	
	/// Method to sort the transactions
	/// - parameter transactions: List of transactions
	/// - returns: [Items]
	/// 
	func getSortedTransactions(_ transactions: Transactions?) -> [Items]? {
		let sorted = transactions?.items?
			.sorted { $0.transactionDetail?.bookingDateObject ?? Date.distantPast
				> $1.transactionDetail?.bookingDateObject ?? Date.distantPast }
		transaction = sorted
		return sorted
	}
}
