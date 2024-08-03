//
//  Constants.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 01.08.24.
//

import Foundation
import UIKit.UIColor

struct AppColors {
    static let Blue = #colorLiteral(red: 0.2914361954, green: 0.3395442367, blue: 0.4364506006, alpha: 1)
    static let Red = #colorLiteral(red: 0.8352941176, green: 0.3921568627, blue: 0.3137254902, alpha: 1)
    static let OffWhite = #colorLiteral(red: 0.9529411765, green: 0.9490196078, blue: 0.968627451, alpha: 1)
  
    
    
}

extension UIColor {
    static let clrSecondaryBlack = UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 1.00)
    static let clrTextPrimary    = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
    static let clrTextSecondary  = UIColor(red: 0.56, green: 0.56, blue: 0.56, alpha: 1)
}



struct Identifiers {
    static let CategoryCell = "CategoryCell"
    static let ProductCell = "ProductCell"
    static let CartItemCell = "CartItemCell"
}
