//
//  APIManager.swift
//  Foodsie
//
//  Created by Cons Bulaqueña on 21/08/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import Foundation
import Stripe
import Alamofire
import SwiftyJSON

class APIManager
{
    static let shared = APIManager()
    var baseURLString: String? = BACKEND_BASE_URL
    var baseURL : URL {
        if let urlString = self.baseURLString, let url = URL(string: urlString) {
            return url
        } else {
            fatalError()
        }
        
    }
    
    //Create new order
    func createOrder(stripeToken: String, completion: @escaping (JSON) -> Void)
    {
        // 1 generate meal details json

        let cartItems = Cart.currentCart.items
        let cartItemsJSONArray = cartItems.map { item in
            return [
                "meal-id" : item.meal.id!,
                "meal-img" : item.meal.imageURL!,
                "meal-description" : item.meal.description!,
                "meal-price" : item.meal.price!,
                "meal-name" : item.meal.name!,
                "quantity" : item.quantity,
                "subtotal" : item.meal.price! * Double(item.quantity)
            ]
        }
        
        // 2 create parameters for order
        let params: [String : Any] = [
            "access_token" : "",
            "stripe_token" : stripeToken,
            "restaurant_id" : "\(Cart.currentCart.restaurant!.id!)",
            "address" : Cart.currentCart.address!,
            "total" : Cart.currentCart.getTotal()
        ]
        
        
        // 3 send post request to backend
        let url = self.baseURL.appendingPathComponent("createorder")
        let newOrder = Order(stripeToken: stripeToken, restaurantId: Cart.currentCart.restaurant!.id!, orderDetails: cartItemsJSONArray, address: Cart.currentCart.address!)
        newOrder.create() //For firebase
        

        // 4 Charge the user for this order immediately
        Alamofire.request
        
        
        
    }
    
    
    
}
























