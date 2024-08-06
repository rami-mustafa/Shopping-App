//
//  StripeCart.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 05.08.24.
//

import Foundation

import Foundation

let StripeCart = _StripeCart()

final class _StripeCart {

    var cartItems = [Product]()
    private let stripeCreditCardCut = 0.029
    private let flatFeeCents = 30
    var shippingFees = 0

    var subtotal: Int {
        var amount = 0
        for item in cartItems {
            let pricePennies = Int(item.price * 100)
            amount += pricePennies
        }
        return amount
    }

    var processingFees: Int {
        if subtotal == 0 {
            return 0
        }
        let sub = Double(subtotal)
        let feesAndSub = Int(sub * stripeCreditCardCut) + flatFeeCents
        return feesAndSub
    }

    var total: Int {
        return subtotal + processingFees + shippingFees
    }

    func addItemToCart(item: Product) {
        cartItems.append(item)
        NotificationCenter.default.post(name: .cartItemsChanged, object: nil)
    }

    func removeItemFromCart(item: Product) {
        if let index = cartItems.firstIndex(of: item) {
            cartItems.remove(at: index)
            NotificationCenter.default.post(name: .cartItemsChanged, object: nil)
        }
    }

    func clearCart() {
        cartItems.removeAll()
        NotificationCenter.default.post(name: .cartItemsChanged, object: nil)
    }
}

 
extension Notification.Name {
    static let cartItemsChanged = Notification.Name("cartItemsChanged")
}
