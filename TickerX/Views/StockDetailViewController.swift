//
//  StockDetailViewController.swift
//  TickerX
//
//  Created by blackbriar on 5/5/17.
//  Copyright © 2017 com.teressa. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    
    var selectedStock: YQStockResult?

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    @IBOutlet weak var daysHighLabel: UILabel!
    @IBOutlet weak var daysLowLabel: UILabel!
    @IBOutlet weak var yearLowLabel: UILabel!
    @IBOutlet weak var yearHighLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var averageDailyVolumeLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var ebitdaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupUI() {
        guard let stock = selectedStock else { return }
        let percentChange = stock.percentChange
        let positiveChange = percentChange.characters.contains("+")
        if positiveChange {
            priceChangeLabel.textColor = UIColor(hex : 0x53BFFF)
            //priceLabel.textColor = UIColor(red:0.16, green:0.8, blue:0.71, alpha:1.0)
        }
        if stock.priceChange == "--" {
            priceChangeLabel.text = stock.percentChange
        } else {
            priceChangeLabel.text = stock.priceChange + " (\(stock.percentChange))"
        }
        
        nameLabel.text = stock.name
        symbolLabel.text = stock.symbol
        priceLabel.text = stock.price
        daysHighLabel.text = stock.daysHigh
        daysLowLabel.text = stock.daysLow
        yearHighLabel.text = stock.yearHigh
        yearLowLabel.text = stock.yearLow
        volumeLabel.text = stock.volume
        averageDailyVolumeLabel.text = stock.averageDailyVolume
        marketCapLabel.text = stock.marketCap
        ebitdaLabel.text = stock.ebitda
        currencyLabel.text = stock.currency
    }

}
