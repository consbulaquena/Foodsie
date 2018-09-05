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
              
                
                let restaurantAddress = json["restaurant"]["address"].string!
                let shippingAddress = json["adress"].string!
                self.getLocation(restaurantAddress, title: "Restaurant", completion: { (sourceLocation) in
                    self.source = sourceLocation
                    self.getLocation(shippingAddress, title: "You", completion: { (destinationLocation) in
                        self.destination = destinationLocation
                    
                    
                        //draw directions route on map
                        self.getDirectionsOnMap()
                        
                        
                        
                    })
                })
            
            }
        }
    }
}


extension TrackOrderViewController : MKMapViewDelegate
{
    // convert a string address into location in map
    func getLocation(_ address: String, title: String, completion: @escaping(MKPlacemark) -> Void)
    {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if error != nil {
                print("Error translating location into placemark: ", error)
            }
            
            if let placemark = placemarks?.first {
                let coordinate = placemark.location!.coordinate
                
                //create pin on the map
                let pin = MKPointAnnotation()
                pin.coordinate = coordinate
                pin.title = title
                self.mapView.addAnnotation(pin)
                completion(MKPlacemark(placemark: placemark))
                
            }
        }
    }
    
    func getDirectionsOnMap()
    {
      let request = MKDirectionsRequest()
        request.source = MKMapItem(placemark: source!)
        request.destination = MKMapItem(placemark: destination!)
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            if error != nil {
                print("error calculating directions: ", error)
            } else {
                // show routes now
                self.showRoute(response: response!)
            }
        
    }
    
}

    func showRoute(response: MKDirectionsResponse)
    {
        for route in response.routes {
            self.mapView.add(route.polyline, level: .aboveRoads)
            
        }
        
        //zoom map into route
        var zoomRect = MKMapRectNull
        for annotation in self.mapView.annotations {
            let annotationPoint = MKMapPointForCoordinate(annotation.coordinate)
            let pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1)
            zoomRect = MKMapRectUnion(zoomRect, pointRect)
            
        }
    
    
    }
}
