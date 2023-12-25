//
//  String+Decimal.swift
//  CoreDataDemo
//
//  Created by Vikas Salian on 26/12/23.
//

import Foundation

extension String{
    
    func toDecimal() -> Decimal?{
        let result = NumberFormatter().number(from: self)?.decimalValue
        return result
    }
}
