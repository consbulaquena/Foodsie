//
//  RestaurantCell.swift
//  Foodsie
//
//  Created by Cons Bulaqueña on 04/07/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit
import Alamofire

class RestaurantCell : UITableViewCell
{
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var restoTypeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var restaurant: Restaurant! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        self.addressLabel.text = restaurant.address
        self.nameLabel.text = restaurant.name
        self.logoImageView.image = nil
        
        
    }
    
}



