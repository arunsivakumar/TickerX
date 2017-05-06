//
//  String+NumberFromatter.swift
//  TickerX
//
//  Created by blackbriar on 5/5/17.
//  Copyright © 2017 com.teressa. All rights reserved.
//

import Foundation

extension String {
    
    func formatString() -> String? {
        guard self.stringAsDouble() != nil
            else { return nil}
        return String(format: "%.02f", self)
    }
    
    func stringAsDouble() -> Double? {
        return NumberFormatter().number(from: self)?
            .doubleValue
    }
}
