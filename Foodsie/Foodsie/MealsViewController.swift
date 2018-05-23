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
    
}

//Mark: UITableview Datasource
extension MealsViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath)
        return cell
    }
}
