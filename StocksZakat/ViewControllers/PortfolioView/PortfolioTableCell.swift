//
//  PortfolioTableCell.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 05.04.21.
//

import UIKit

class PortfolioTableCell: UITableViewCell {

    @IBOutlet weak var stockSymbol: UILabel!
    @IBOutlet weak var stockCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
