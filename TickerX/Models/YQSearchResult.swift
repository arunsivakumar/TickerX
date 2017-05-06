//
//  YQResult.swift
//  TickerX
//
//  Created by blackbriar on 4/28/17.
//  Copyright © 2017 com.teressa. All rights reserved.
//

import Foundation
import SwiftyJSON

struct YQSearchResult {
    
    let name: String
    let symbol: String
    let exchange: String
    let typeDisplay: String
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.symbol = json["symbol"].stringValue
        self.exchange = json["exchDisp"].stringValue
        self.typeDisplay = json["typeDisp"].stringValue
    }
}
