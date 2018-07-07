//
//  RestaurantListingTableViewController.swift
//  Foodsie
//
//  Created by Cons Bulaqueña on 18/05/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit



class RestaurantListingTableViewController: UITableViewController
{
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    
    //empty array of restaurants
    var restaurants = [Restaurant]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBarButtonItem.target = self.revealViewController()
        menuBarButtonItem.action = #selector(SWRevealViewController.revealToggle(_: ))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    
    getRestaurants()
        
    }
    
    //fetch data
    func getRestaurants()
    {
        Restaurant.getRestaurants { (restaurants) in
            DispatchQueue.main.async {
                self.restaurants = restaurants
                self.tableView.reloadData()
                
            }
            
        }
    }
    
    
}

// Mark: UITableViewDataSource
//implement UITableView data source

extension RestaurantListingTableViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    //fetch data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
        cell.selectionStyle = .none //disable grey selection
       
        cell.restaurant = self.restaurants[indexPath.row]
        return cell
    }

}

