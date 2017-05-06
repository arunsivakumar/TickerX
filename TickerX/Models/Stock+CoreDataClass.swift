//
//  Stock+CoreDataClass.swift
//  TickerX
//
//  Created by blackbriar on 4/26/17.
//  Copyright © 2017 com.teressa. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON


public class Stock: NSManagedObject {
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(json: JSON) {
        print("JSON IS \(json)")
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Stock", in: context)!
        print("HHOHJHH")
        super.init(entity: entity, insertInto: context)
        self.name = json["name"].stringValue
        self.symbol = json["symbol"].stringValue
        self.exchange = json["exchDisp"].stringValue
        self.typeDisplay = json["typeDispd"].stringValue
    }
    
    convenience init(name: String, symbol: String, exchange: String, typeDisplay: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Stock", in: context)!
        self.init(entity: entity, insertInto: context)
        self.name = name
        self.symbol = symbol
        self.exchange = exchange
        self.typeDisplay = typeDisplay
    
    }
}
