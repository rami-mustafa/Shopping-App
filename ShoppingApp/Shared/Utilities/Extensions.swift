//
//  Extensions.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 05.08.24.
//

import Foundation





extension Int {
    
    func penniesToFormattedCurrency() -> String {
        let dollars = Double(self) / 100
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        if let dollarString = formatter.string(from: dollars as NSNumber) {
            return dollarString
        }
        
        return "£0.00"
    }
}
