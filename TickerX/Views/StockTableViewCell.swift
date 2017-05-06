//
//  StockTableViewCell.swift
//  TickerX
//
//  Created by blackbriar on 4/26/17.
//  Copyright © 2017 com.teressa. All rights reserved.
//

import UIKit

class StockTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    var stock: YQStockResult!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell() {
        nameLabel.text = stock.name
        symbolLabel.text = stock.symbol
        priceLabel.text = stock.price
        priceLabel.textColor = stock.percentChange.characters.contains("+") ? UIColor(hex: 0x53BFFF) : UIColor(hex: 0xFF6575)
    }
}
