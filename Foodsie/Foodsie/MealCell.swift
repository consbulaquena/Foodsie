//
//  MealCell.swift
//  Foodsie
//
//  Created by Cons Bulaqueña on 27/07/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit
import Alamofire

class MealCell : UITableViewCell
{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!

    var meal: Meal! {
        didSet {
            self.updateUI()
            
        }
    }
    
    func updateUI()
    {
        nameLabel.text = meal.name
        descriptionLabel.text = meal.description
        priceLabel.text = "\(meal.price!)"
        
        let imageURL = URL(string: meal.imageURL!)
        Alamofire.request(imageURL!).responseData { (responseData) in
            DispatchQueue.main.async {
                if let imageData = responseData.data {
                    self.thumbnailImageView.image = UIImage(data: imageData)
                }

            }
        }
        
    }
    
    
    
    
    
    
}




























