//
//  Constants.swift
//  TickerX
//
//  Created by blackbriar on 4/26/17.
//  Copyright © 2017 com.teressa. All rights reserved.
//

import Foundation
class Constants {
    
    static let searchEndPoint = "http://autoc.finance.yahoo.com/autoc"
    
    static let symbolsUrlPrefix = "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20("
    static let symbolsUrlSuffix = ")&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&format=json"
    
    static let schedules = "schedules/"
    
    static let inbound = "R"
    
    static let outbound = "A"
    
    static let urlBorder = "%22"
    static let urlSeparator = "%2C"
    
    
    static let locationNotificationKey = "com.teressa.locationNotificationKey"
}
