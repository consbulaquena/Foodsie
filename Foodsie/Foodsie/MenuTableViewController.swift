//
//  MenuTableViewController.swift
//  Foodsie
//
//  Created by Cons Bulaqueña on 18/06/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class MenuTableViewController : UITableViewController
{
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = User.current.name
        
        //implem. Alamofire
        if let pictureURLString = User.current.pictureURL, let url = URL(string: pictureURLString){
            Alamofire.request(url).responseData { (data) in
                DispatchQueue.main.async {
                    self.avatarImageView.image = UIImage(data: data.data)
                }
            }
        }
    
    }
    //Before the segue happening
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowLoginViewController" {
            FBLoginManager.shared.logOut()
            try! Auth.auth().signOut()
            User.current.resetData()
            
            
            
        }
    }
    
}


