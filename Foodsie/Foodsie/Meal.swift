//
//  Meal.swift
//  Foodsie
//
//  Created by Cons Bulaqueña on 27/07/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import Foundation
import SwiftyJSON

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
        imageURL = json["imageURL"]
        
    }
    
    
}
