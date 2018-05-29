//
//  CartViewController.swift
//  Foodsie
//
//  Created by Cons Bulaqueña on 29/05/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit

class CartViewController : UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
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
