//
//  Restaurant.swift
//  Foodsie
//
//  Created by Cons Bulaqueña on 26/06/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import Foundation
import SwiftyJSON
import Firebase


class Restaurant
{
    var id: String?
    var name: String?
    var address: String?
    var logoURL: String?
    var phone: String?
    var cuisine: String?
    
    //from swifty json
    init(json: JSON)
    {
        id = json["id"].string
        name = json["name"].string
        address = json["address"].string
        logoURL = json["logoURL"].string
        phone = json["phone"].string
        cuisine = json["cuisine"].string
    }
    
    
    //create reference
    class func getRestaurants(completion: @escaping ([Restaurant]) -> Void)
    {
        let restaurantsRef = Database.database().reference().child("restaurants")
        restaurantsRef.observeSingleEvent(of: .value) { (snapshot) in
            var restaurants = [Restaurant]()
            
            //data for restos to use from
            for childSnapshot in snapshot.children {
                let value = (childSnapshot as! DataSnapshot).value
                let json = JSON(value)
                restaurants.append(Restaurant(json: json))
                
            }
            
            completion(restaurants)
        }
        
    }
    
    func toDictionary() -> [String : Any]
    {
        return [
            "id" : id!,
            "name" : name!,
            "address" : name!,
            "logoURL" : logoURL!,
            "phone" : phone!
            
            
        ]
    }
    
}
