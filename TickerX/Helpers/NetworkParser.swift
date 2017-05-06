//
//  NetworkParser.swift
//  TickerX
//
//  Created by blackbriar on 4/26/17.
//  Copyright © 2017 com.teressa. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON

class NetworkParser {
    
    static let sharedInstance = NetworkParser()
    
    func parseSearchResults(json:JSON) -> [YQSearchResult] {
        print("Parsing trip please wait")
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        moc.parent = context
//        context.
        var stocks = [YQSearchResult]()
        let jsonArray = json["ResultSet"]["Result"].arrayValue
        for stock in jsonArray {
            let stock = YQSearchResult(json: stock)
            print("Name of stock is \(stock.name)")
            stocks.append(stock)
    //        let places = SkyScannerPlace.placesWithJSON(json: json["Places"])
    //        let segments =
    //        print("Parsed request ------\(request)")
        }
        print("STOCKS is \(stocks)")
        return stocks
        
    }
    
    func parseStockResult(json:JSON) -> YQStockResult {
//        print("Parsing stock please wait")
        let json = json["query"]["results"]["quote"]
        let YQstock = YQStockResult(json: json)
//        print("STOCK ask \(YQstock.price)")
        //        let places = SkyScannerPlace.placesWithJSON(json: json["Places"])
        //        let segments =
        //        print("Parsed request ------\(request)")

        return YQstock
        
    }
}
