//
//  Firebase+Utils.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 03.08.24.
//

import Foundation
import Firebase


extension Firestore {
    var categories: Query {
        return collection("categories").order(by: "timeStamp", descending: true)
    }
    
    func products(category: String) -> Query {
        return collection("products").whereField("category", isEqualTo: category).order(by: "timeStamp", descending: true)
    }
}
