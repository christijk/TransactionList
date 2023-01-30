//
//  TransactionTableViewCell.swift
//  WorldOfPAYBACK
//
//  Created by Christi John on 27/01/2023.
//

import UIKit
import Combine

class TransactionTableViewCell: UITableViewCell {

	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var partnerNameLabel: UILabel!
	@IBOutlet weak var transactionDescLabel: UILabel!
	@IBOutlet weak var amountLabel: UILabel!
	
	var transactionCellVM: TransactionCellDisplayable? {
		didSet {
			dateLabel.text = transactionCellVM?.dateFormatted
			partnerNameLabel.text = transactionCellVM?.partnerName
			transactionDescLabel.text = transactionCellVM?.transactionDesc
			amountLabel.text = transactionCellVM?.amountWithCurrency
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
	}
	
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
