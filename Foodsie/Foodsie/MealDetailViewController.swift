//
//  MealDetailViewController.swift
//  Foodsie
//
//  Created by Cons Bulaqueña on 28/05/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit
import Alamofire

class MealDetailViewController : UIViewController
{
    @IBOutlet weak var quantityButtonsContainerView: UIView!
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealDecriptionLabel: UILabel!
    @IBOutlet weak var cartBarButtonItem: UIBarButtonItem! {
        didSet {
        //
    }
    }
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    var meal: Meal!
    var restaurant: Restaurant!
    var quantity = 1
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = cartBarButtonItem
        quantityButtonsContainerView.layer.cornerRadius = 21.0
        quantityButtonsContainerView.layer.borderColor = UIColor.lightGray.cgColor
        quantityButtonsContainerView.layer.borderWidth = 1.0
        quantityButtonsContainerView.layer.masksToBounds = true
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        title = "Meal"
        mealNameLabel.text = meal.name
        
        if let price = meal.price {
            priceLabel.text = "Php \(price)"
        }

        mealDecriptionLabel.text = meal.description
        if let imageURLString = meal.imageURL {
            let imageURL = URL(string: imageURLString)
        
            //Alamofire use to dL image
            Alamofire.request(imageURL!).response { (responseData) in
                DispatchQueue.main.async {
                    if let imageData = responseData.data {
                        self.mealImageView.image = UIImage(data: imageData)
                        
                    }
                }
            }
            
        }
        updateTotalLabel()
        quantityLabel.text = "\(quantity)"
        
    }
    func updateTotalLabel()
    {
        if let price = meal.price {
            totalLabel.text = "Php \(price * Double(quantity))"
        }
    }
    
    // MARK: - Quantity
    

    @IBAction func addQuantity(_ sender: Any)
    {
        if quantity < 99 {
            quantity += 1
            quantityLabel.text = String(quantity)
        
            updateTotalLabel()
        }
    }
    
    @IBAction func decreasedQuantity(_sender: Any)
    {
        if quantity > 0 {
            quantity -= 1
            quantityLabel.text = String(quantity)
        
            updateTotalLabel()
        }
    }
    // MARK - Add to Cart
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
