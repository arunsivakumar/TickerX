//
//  YQStockResult.swift
//  TickerX
//
//  Created by blackbriar on 5/5/17.
//  Copyright © 2017 com.teressa. All rights reserved.
//

import Foundation
import SwiftyJSON

struct YQStockResult {
    
    let name: String
    let symbol: String
    var open: String
    var daysHigh: String
    var daysLow: String
    var volume: String
    var averageDailyVolume: String
    var yearHigh: String
    var yearLow: String
    var marketCap: String
    var ebitda: String
    var priceChange: String
    var currency: String
    var price: String
    //var percentChangeDup: (change: String, isPositive: Bool?) = ("--", nil)
    var percentChange: String
    
    init(json: JSON) {
        self.name = json["Name"].stringValue
        self.symbol = json["Symbol"].stringValue
        self.open = json["Open"].stringValue
        self.daysHigh = json["DaysHigh"].stringValue
        self.daysLow = json["DaysLow"].stringValue
        self.volume = json["Volume"].stringValue
        self.averageDailyVolume = json["AverageDailyVolume"].stringValue
        self.yearHigh = json["YearHigh"].stringValue
        self.yearLow = json["YearLow"].stringValue
        self.marketCap = json["MarketCapitalization"].stringValue
        self.ebitda = json["EBITDA"].stringValue
        self.priceChange = json["typeDisp"].stringValue
        self.currency = json["Currency"].stringValue
        self.price = json["Ask"].string ?? "N/A"
        self.priceChange = json["Change"].string ?? "--"
        self.percentChange = json["PercentChange"].stringValue
        
    }
}
