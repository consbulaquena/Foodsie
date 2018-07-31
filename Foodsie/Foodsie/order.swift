//
//  order.swift
//  Foodsie
//
//  Created by Cons Bulaqueña on 01/08/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Firebase


class Order
{
    //1 properties
    //Stripe give token each transaction
    var stripeToken: String?
    var restaurantId: String?
    var orderDetails: [JSON]?
    var orderDetailDictionaries: [[String: Any]]?
    var address: String?
    
    
    

    
    //2 initializers
        // json if we download frm firebase
        // when dL data from stripe
    
    
    init(json: JSON)
    {
        stripeToken = json["stripeToken"].string
        restaurantId = json["restaurantId"].string
        address = json["address"].string
        orderDetails = json["orderDetails"].array
        
        //hmmm
    }
    
        // locally initializer
    init(stripeToken: String, restaurantId: String, orderDetails: [[String: Any]], address: String)
    {
        self.stripeToken = stripeToken
        self.restaurantId = restaurantId
        self.orderDetailDictionaries = orderDetails
        self.address = address
    }
    
    // create method, save to firebase
    func create()
    {
        let restaurantNewOrderRef = Database.database().reference().child("restaurants/\(restaurantId!)/orders").childByAutoId()
        
        let orderId = restaurantNewOrderRef.key
        let currentUserId = User.current.id!
        let latestOrderRef = Database.database()
        
    }
    
    //3. get latest order
    
    
}
