//
//  TrackOrderViewController.swift
//  UberEats
//
//  Created by D Tran on 11/24/17.
//  Copyright © 2017 Wallie. All rights reserved.
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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    
    var orderDetails = [JSON]()
    var order: Order!
    
    var destination: MKPlacemark?
    var source: MKPlacemark?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBarButtonItem.target = self.revealViewController()
        menuBarButtonItem.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        tableView.dataSource = self
        mapView.delegate = self
        
        getLatestOrder()
    }
    
    func getLatestOrder()
    {
        Order.getLatestOrder { (json) in
            DispatchQueue.main.async {
                let latestOrder = Order(json: json)
                self.orderDetails = latestOrder.orderDetails!
                self.tableView.reloadData()
                self.orderStatusLabel.text = json["status"].string!
                
                let restaurantAddress = json["restaurant"]["address"].string!
                let shippingAddress = json["address"].string!
                self.getLocation(restaurantAddress, title: "Restaurant", completion: { (sourceLocation) in
                    self.source = sourceLocation
                    self.getLocation(shippingAddress, title: "You", completion: { (destinationLocation) in
                        self.destination = destinationLocation
                        
                        // draw directions route on the map
                        self.getDirectionsOnMap()
                    })
                })
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension TrackOrderViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackOrderItemCell", for: indexPath) as! TrackOrderItemCell
        cell.orderDetail = orderDetails[indexPath.row]
        return cell
    }
}

extension TrackOrderViewController : MKMapViewDelegate
{
    // convert an string address into a location on the map
    func getLocation(_ address: String, title: String, completion: @escaping (MKPlacemark) -> Void)
    {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if error != nil {
                print("ERROR TRANSLATING LOCATION INTO PLACEMARK: ", error)
            }
            
            if let placemark = placemarks?.first {
                let coordinate = placemark.location!.coordinate
                // create a pin on the map
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
                print("ERROR CALCULATING DIRECTIONS: ", error)
            } else {
                // show the routes now!
                self.showRoute(response: response!)
            }
        }
    }
    
    func showRoute(response: MKDirectionsResponse)
    {
        for route in response.routes {
            self.mapView.add(route.polyline, level: .aboveRoads)
        }
        
        // zoom the map into the route
        var zoomRect = MKMapRectNull
        for annotation in self.mapView.annotations {
            let annotationPoint = MKMapPointForCoordinate(annotation.coordinate)
            let pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1)
            zoomRect = MKMapRectUnion(zoomRect, pointRect)
        }
        
        let insetWidth = -zoomRect.size.width * 0.2
        let insetHeight = -zoomRect.size.height * 0.2
        let insetRect = MKMapRectInset(zoomRect, insetWidth, insetHeight)
        
        self.mapView.setVisibleMapRect(insetRect, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
    {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        
        return renderer
    }
}




















