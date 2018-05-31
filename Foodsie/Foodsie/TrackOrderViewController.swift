//
//  TrackOrderViewController.swift
//  Foodsie
//
//  Created by Cons Bulaqueña on 01/06/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit
import MapKit

class TrackOrderViewController : UIViewController
{
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var orderStatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
