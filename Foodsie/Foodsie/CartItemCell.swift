//
//  CartItemCell.swift
//  UberEats
//
//  Created by D Tran on 3/28/18.
//  Copyright © 2018 Wallie. All rights reserved.
//

class CartItemCell: UITableViewCell
{
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealSubtotalLabel: UILabel!
    
    var cartItem: CartItem! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        quantityLabel.text = String(cartItem.quantity)
        mealNameLabel.text = cartItem.meal.name
        mealSubtotalLabel.text = String(Double(cartItem.quantity) * cartItem.meal.price!)
    }
}
