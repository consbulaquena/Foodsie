//
//  Order.swift
//  UberEats
//
//  Created by D Tran on 3/27/18.
//  Copyright © 2018 Wallie. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Firebase

class Order
{
    // properties
    var stripeToken: String?
    var restaurantId: String?
    var orderDetails: [JSON]?
    var orderDetailsDictionaires: [[String : Any]]?
    var address: String?
    
    // initializers
        // - json if we download from firebase
    init(json: JSON)
    {
        stripeToken = json["stripeToken"].string
        restaurantId = json["restaurantId"].string
        address = json["address"].string
        orderDetails = json["orderDetails"].array
    }
    
        // - locally
    init(stripeToken: String, restaurantId: String, orderDetails: [[String : Any]], address: String)
    {
        self.stripeToken = stripeToken
        self.restaurantId = restaurantId
        self.orderDetailsDictionaires = orderDetails
        self.address = address
    }
    
    // create, save it to firebase
    func create()
    {
        let restaurantNewOrderRef = Database.database().reference().child("restaurants/\(restaurantId!)/orders").childByAutoId()
        let orderId = restaurantNewOrderRef.key
        let currentUserId = User.current.id!
        let latestOrderRef = Database.database().reference().child("users/\(currentUserId)/latest-order")
        let restaurant = Cart.currentCart.restaurant!
        let orderDictionary: [String : Any] = [
            "orderId" : orderId,
            "stripeToken" : stripeToken!,
            "restaurant" : restaurant.toDictionary(),
            "orderDetails" : orderDetailsDictionaires!,
            "address" : address!,
            "status" : "Preparing",
            "total" : Cart.currentCart.getTotal(),
            "customer" : User.current.toDictionary()
        ]
        
        // save as the user's latest order
        latestOrderRef.setValue(orderDictionary)
        // save as the restaurant's new order
        restaurantNewOrderRef.setValue(orderDictionary)
    }
    
    // get latest order
    class func getLatestOrder(completion: @escaping (JSON) -> Void)
    {
        let currentUserId = User.current.id!
        let latestOrderRef = Database.database().reference().child("users/\(currentUserId)/latest-order")
        latestOrderRef.observeSingleEvent(of: .value) { (snapshot) in
            let json = JSON(snapshot.value)
            completion(json)
        }
    }
}
























