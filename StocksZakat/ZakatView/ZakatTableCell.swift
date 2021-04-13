//
//  ZakatTableCell.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 10.04.21.
//

import UIKit

class ZakatTableCell: UITableViewCell {

    @IBOutlet weak var stockSymbolLabel: UILabel!
    
    @IBOutlet weak var stockPriceLabel: UILabel!
    
    @IBOutlet weak var youOwnLabel: UILabel!
    
    @IBOutlet weak var zakatPerStockLabel: UILabel!
    
    @IBOutlet weak var userZakatLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
