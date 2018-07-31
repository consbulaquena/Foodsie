
//
//  Cart.swift
//  UberEats
//
//  Created by D Tran on 3/27/18.
//  Copyright © 2018 Wallie. All rights reserved.
//

import Foundation

class Cart
{
    static let currentCart = Cart()
    
    var restaurant: Restaurant?
    var items = [CartItem]()
    var address: String?
    
    func getTotalQuantity() -> Int {
        var total = 0
        for item in items {
            total += item.quantity
        }
        return total
    }
    
    func getTotal() -> Double {
        var total = 0.0
        for item in items {
            total += Double(item.quantity) * item.meal.price!
        }
        return total
    }
    
    func reset() {
        restaurant = nil
        items.removeAll()
        address = nil
    }
}

















