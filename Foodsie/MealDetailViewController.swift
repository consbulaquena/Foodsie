//
//  MealDetailViewController.swift
//  Foodsie
//
//  Created by Cons Bulaqueña on 28/05/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit

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
        
        title = "Meal"
        mealNameLabel.text = meal.name
        mealDecriptionLabel.text = meal.description
        if let image
        
    }
}










