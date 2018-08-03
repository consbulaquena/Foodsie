//
//  CartViewController.swift
//  Foodsie
//
//  Created by Cons Bulaqueña on 29/05/2018.
//  Copyright © 2018 consios. All rights reserved.
//

// TO DO
// [] outlets / connections
// [] if there's no item in cart, tell userd do some browsing
// [] populate the current cart's items into table view
// [] enter shipping address
// [] get user's current location via corelocation
// [] interpret user's shipping address, put pin in map


import UIKit
import MapKit

class CartViewController : UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var cartTotalLabel: UILabel!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addPaymentButton: UIButton!
    @IBOutlet weak var addressFieldView: UIView!
    
    
    var cartItems = [CartItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Menu code
        menuBarButtonItem.target = self.revealViewController()
        menuBarButtonItem.action = #selector(SWRevealViewController.revealToggle(_: ))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

        
        tableView.dataSource = self
        
        if Cart.currentCart.items.count == 0 {
            // tehre's no item here.
            // if there's no item in cart, tell the user to do some browsing
            let emptyCartLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80))
            emptyCartLabel.center = self.view.center
            emptyCartLabel.textAlignment = .center
            emptyCartLabel.text = "YOUR CART IS EMPTY.\n PLEASE SELECT SOME MEALS."
            emptyCartLabel.numberOfLines = 3
            
            self.view.addSubview(emptyCartLabel)
        } else {
            // display all the items in cart

        }
    }
    
    
        
        
}

//MARK: - UITableViewDataSource

extension CartViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath)
        return cell
    }
}
