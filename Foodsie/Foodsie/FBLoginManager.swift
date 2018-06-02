//
//  FBLoginManager.swift
//  Foodsie
//
//  Created by Cons Bulaqueña on 02/06/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import SwiftyJSON

class FBLoginManager
{
   static let shared = FBSDKLoginManager()
    
    public class func getFBUserData(completion: @escaping () -> Void)
    {
        if FBSDKAccessToken.current() != nil {
            //if not nil user login
            let request = FBSDKGraphRequest(graphPath: "me", parameters: ["Field" :
        "name, email, picture.type(normal) "])!
            request.start(completionHandler: { (connection, result, error) in
            if error == nil {
                let json = JSON(result!)
                
            //this time we have users email/id
            
                print(json)
                completion()
                
            }
        })
    }
}
}
