//
//  LoginViewController.swift
//  Foodsie
//
//  Created by Cons Bulaqueña on 02/06/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit


class LoginViewController : UIViewController
{
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    var loginSuccess = false
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showRestaurantsListing()
        
    }
    func showRestaurantsListing()
    {
        if FBSDKAccessToken.current() != nil && loginSuccess {
            performSegue(withIdentifier: "ShowRestaurantListing", sender: nil)
        }
        
    }
    
    // MARK: - Target / Action
    
    @IBAction func facebookLoginDidTap()
    {
        if FBSDKAccessToken.current() != nil {
            loginSuccess = true
            showRestaurantsListing()
        } else {
           //1. REQUEST LOGIN TOKEN FROM FACEBOOK
            FBLoginManager.shared.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
                if error == nil {
                    let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                    
            //2. LOGIN USER TO FIREBASE BACKEND
                    
                    Auth.auth().signIn(with: credential, completion: { (user, error) in
                        if let error = error {
                            print("Error Firebase login: ",  error.localizedDescription)
                            return
                        }
          //User is logged in, show restaurants
            //3. get user's data from fb profile
                        FBLoginManager.getFBUserData {
                            self.loginSuccess = true
                            
            // 4. SHOW RESTO listing
                        self.showRestaurantsListing()
                        }
                        
                    })
                    
                } else {
                    print("error facebook login:", error!.localizedDescription)
                    
                }
            }
            
        }
    }
    
    @IBAction func facebookLogoutDidTap()
    {
        
    }

}




