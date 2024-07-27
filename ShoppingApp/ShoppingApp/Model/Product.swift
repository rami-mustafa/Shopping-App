//
//  Product.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 27.07.24.
//

 
import Foundation

// MARK: - Product
struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let image: String
}
