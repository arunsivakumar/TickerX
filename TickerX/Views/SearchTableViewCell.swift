//
//  SearchTableViewCell.swift
//  TickerX
//
//  Created by blackbriar on 4/27/17.
//  Copyright © 2017 com.teressa. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var symbolLabel: UILabel!
    
    @IBOutlet weak var exchangeLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
