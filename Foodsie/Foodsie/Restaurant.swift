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
    
    //from swifty json
    init(json: JSON)
    {
        id = json["id"].string
        name = json["name"].string
    
    }
    
    
    
}
























