//
//  Meal.swift
//  Foodsie
//
//  Created by Cons Bulaqueña on 27/07/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import Foundation
import SwiftyJSON
import Firebase

class Meal
{
    var id: String?
    var description: String!
    var name: String?
    var imageURL: String?
    var price: Double?
    
    init(json: JSON)
    {
        id = json["id"].string
        name = json["name"].string
        price = json["price"].double
        description = json["description"].string
        imageURL = json["imageURL"].string
        
    }
    
    class func getMeals(withRestaurantId restaurantId: String, completion: @escaping ([Meal]) -> Void)
    {
        let ref = Database.database().reference().child("restaurants/\(restaurantId)/meals")
        ref.observeSingleEvent(of: .value) { (snapshot) in
            var meals = [Meal]()
            for childSnapshot in snapshot.children {
                let mealJSON = JSON((childSnapshot as! DataSnapshot ).value)
                let meal = Meal(json: mealJSON)
                meals.append(meal)
            }
            
            completion(meals)
            
            
        }
    }
}
