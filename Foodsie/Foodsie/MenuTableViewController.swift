//
//  MenuTableViewController.swift
//  Foodsie
//
//  Created by Cons Bulaqueña on 18/06/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit
import Firebase

class MenuTableViewController : UITableViewController
{
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    //Before the segue happening
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowLoginViewController" {
            FBLoginManager.shared.logOut()
            try! Auth.auth().signOut()
            
        }
    }
    
}


