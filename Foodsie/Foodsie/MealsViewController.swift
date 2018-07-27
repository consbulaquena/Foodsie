//
//  MealsViewController.swift
//  Foodsie
//
//  Created by Cons Bulaqueña on 23/05/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit

class MealsViewController: UITableViewController
{
    //pass the restaurant meals
    var restaurant: Restaurant!
    var meals = [Meal]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        tableView.rowHeight = 140.0
        title = restaurant.name!
        
        getMeals()
    }
    
    func getMeals()
    {
        Meal.getMeals(withRestaurantId: restaurant.id!) { (meals) in
            DispatchQueue.main.async {
                self.meals = meals
                self.tableView.reloadData()
                
            }
        }
    }
}

//Mark: UITableview Datasource
extension MealsViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as! MealCell
        return cell
    }
}
