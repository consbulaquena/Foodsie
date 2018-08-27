//
//  TrackOrderViewController.swift
//  Foodsie
//
//  Created by Cons Bulaqueña on 01/06/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON

class TrackOrderViewController : UIViewController
{
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var orderStatusLabel: UILabel!
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    

    var order: Order!
    
    var destination: MKPlacemark?
    var source: MKPlacemark?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Menu Bar code
        menuBarButtonItem.target = self.revealViewController()
        menuBarButtonItem.action = #selector(SWRevealViewController.revealToggle(_: ))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        mapView.delegate = self
        
        getLatestOrder()
    }
    
    func getLatestOrder()
    {
        Order.getLatestOrder { (json) in
            DispatchQueue.main.async {
              
                
                let restaurantAdress = json["restaurant"]["address"].string!
                let shippingAddress = json["adress"].string!
            
            
            }
        }
    }
}


extension TrackOrderViewController : MKMapViewDelegate
{
    // convert a string address into location in map
    
}




