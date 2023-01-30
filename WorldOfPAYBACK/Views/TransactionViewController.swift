//
//  ViewController.swift
//  WorldOfPAYBACK
//
//  Created by Christi John on 27/01/2023.
//

import UIKit
import Combine
import SwiftUI

class TransactionViewController: UIViewController {

	private struct Constants {
		static let title = "Transactions"
		static let filters = "Filter"
		static let ok = "Okay"
		static let retry = "Retry";
		static let cancel = "Clear & Cancel"
	}
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var totalLabel: UILabel!
	@IBOutlet weak var totalView: UIView!
	
	var viewModel: TransactionViewModel?
	var subscriptions = Set<AnyCancellable>()
	var onFilterSelection: ((Int) -> ())?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		configureUI()
		bindViewModel()
	}

}

// MARK:- Custom methods
//
extension TransactionViewController {
	func configureUI() {
		self.title = Constants.title.localized()
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.filters.localized(),
															style: .plain,
															target: self,
															action: #selector(filterAction))

		tableView.registerCell(TransactionTableViewCell.self)
		tableView.dataSource = self
		tableView.delegate = self
	}
	
	/// Method to bind ViewModel and View
	/// Using Combine publishers for to and fro communications
	///
	func bindViewModel() {
		// Initialize view model object
		//
		viewModel = TransactionViewModel()
		
		self.viewModel?.$loading
			.receive(on: DispatchQueue.main)
			.sink(receiveValue: { [weak self] value in
				self?.activityIndicator.isHidden = !value
				self?.totalView.isHidden = value
			}).store(in: &subscriptions)
		
		self.viewModel?.$error
			.receive(on: DispatchQueue.main)
			.sink(receiveValue: { [weak self] (title, message) in
				self?.activityIndicator.isHidden = true
				self?.totalView.isHidden = true
				self?.showAlert(title: title, message: message, cancelTitle: Constants.ok.localized())
			}).store(in: &subscriptions)
		
		self.viewModel?.$total
			.receive(on: DispatchQueue.main)
			.assign(to: \.text, on: totalLabel)
			.store(in: &subscriptions)
		
		self.viewModel?.onTransactionAPISuccess
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { [weak self] completion in
				self?.activityIndicator.isHidden = true
				self?.totalView.isHidden = false
			}, receiveValue: { [weak self] _ in
				self?.tableView.reloadData()
			}).store(in: &subscriptions)
		
		self.onFilterSelection = { index in
			let category = self.viewModel?.filters?[safe: index]
			self.viewModel?.filterTransactions(for: category)
			self.dismiss(animated: true)
		}
		
		self.viewModel?.onRandomAPIError
			.receive(on: DispatchQueue.main)
			.sink(receiveValue: { [weak self] (title, msg) in
				self?.totalView.isHidden = true
				self?.showRetryAlert(title, msg)
			}).store(in: &subscriptions)
		
		self.viewModel?.getTransactions(shouldFail: Bool.random())
	}
	
	@objc func filterAction() {
		guard let filters = viewModel?.filters else { return }
		let actionSheet = getActionSheet(filters)
		self.present(actionSheet, animated: true)
	}
	
	func getActionSheet(_ options: [Int]) -> UIAlertController {
		let alert = UIAlertController(title: Constants.filters.localized(),
									  message: nil,
									  preferredStyle: .actionSheet)
		for(index, element) in options.enumerated() {
			alert.addAction(UIAlertAction(title: "Category: \(element)",
										  style: .default) { _ in
				self.onFilterSelection?(index)
			})
		}
		
		alert.addAction(UIAlertAction(title: Constants.cancel.localized(),
									  style: .destructive) { _ in
			self.viewModel?.clearFilters()
		})
		
		return alert
	}
	
	func showRetryAlert(_ title: String, _ message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: Constants.retry.localized(),
									  style: .default) { _ in
			self.viewModel?.getTransactions(shouldFail: false)
		})
		self.present(alert, animated: true, completion: nil)
	}
}

// MARK:- TableView Detasource and Delegates
//
extension TransactionViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView,
				   numberOfRowsInSection section: Int) -> Int {
		viewModel?.numberOfRows ?? 0
	}
	
	func tableView(_ tableView: UITableView,
				   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueCell(
			TransactionTableViewCell.self, indexPath: indexPath)
		let cellViewModel = viewModel?
			.getCellModel(for: indexPath.row)
		cell.transactionCellVM = cellViewModel
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let vm = viewModel?.getDetailModel(for: indexPath.row) else { return }
		
		let detailController = UIHostingController(rootView: TransactionDetailsView(viewModel: vm))
		navigationController?.pushViewController(detailController, animated: true)
	}
}
