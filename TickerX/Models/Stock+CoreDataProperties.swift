//
//  Stock+CoreDataProperties.swift
//  TickerX
//
//  Created by blackbriar on 4/26/17.
//  Copyright © 2017 com.teressa. All rights reserved.
//

import Foundation
import CoreData


extension Stock {

    @nonobjc public class func afetchRequest() -> NSFetchRequest<Stock> {
        return NSFetchRequest<Stock>(entityName: "Stock")
    }

    @NSManaged public var name: String
    @NSManaged public var symbol: String
    @NSManaged public var exchange: String
    @NSManaged public var typeDisplay: String
    

}
