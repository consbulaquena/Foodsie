//
//  PaymentViewController.swift
//  Foodsie
//
//  Created by Cons Bulaqueña on 23/08/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit
import Stripe
import SwiftyJSON

class PaymentViewController : UIViewController
{
    @IBOutlet weak var cardTextField: STPPaymentCardTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Payment"
    }
    
    @IBAction func placeOrder()
    {
        //get latest order
        Order.getLatestOrder { (json) in
            DispatchQueue.main.async {
                if json == JSON.null || json["status"].string == "Delivered" {
             // if latest order is complete || nil
             // then we can create a new order
                    let card = self.cardTextField.cardParams STPAPIClient.shared().createToken(with: card, completion: { (token, error) in
                        if let error = error {
                            print("Error stripe generate card token", error)
                        } else if let stripeToken = token {
                            
                        }
                        })
                } else {
                    // else show an alert that they already have order on way
                    let alertVC = UIAlertController(title: "Order is on the way", message: "You have existing order isn't completed yet", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                    let okAction = UIAlertAction(title: "Go to the order", style: .default, handler: { (action) in
                        self.performSegue(withIdentifier: "ShowOrderViewController", sender: self)
                    })
                    alertVC.addAction(cancelAction)
                    alertVC.addAction(okAction)
                    
                    self.present(alertVC, animated: true, completion: nil)
                }
                
            }
        }
        
        
        
    }
    
}












