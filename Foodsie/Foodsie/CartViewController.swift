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
import CoreLocation

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
    var locationManager: CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentLocation()
        
        
        //Menu code
        menuBarButtonItem.target = self.revealViewController()
        menuBarButtonItem.action = #selector(SWRevealViewController.revealToggle(_: ))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

        
        tableView.dataSource = self
        addressTextField.delegate = self
        
        
        if Cart.currentCart.items.count == 0 {

            toggleEmptyCart(isHidden: true)
            
            // tehre's no item here.
            // if there's no item in cart, tell the user to do some browsing
            let emptyCartLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80))
            emptyCartLabel.center = self.view.center
            emptyCartLabel.textAlignment = .center
            emptyCartLabel.text = "Your cart is empty.\n Please add some meals."
            emptyCartLabel.numberOfLines = 3
            
            self.view.addSubview(emptyCartLabel)
        } else {
            // display all the items in cart
            toggleEmptyCart(isHidden: false)
            getMealsInCart()
        }
    }
    
    func toggleEmptyCart(isHidden: Bool)
    {
        tableView.isHidden = isHidden
        totalView.isHidden = isHidden
        addressFieldView.isHidden = isHidden
        addPaymentButton.isHidden = isHidden
    }
    
    func getMealsInCart()
    {
        cartItems = Cart.currentCart.items
        tableView.reloadData()
        cartTotalLabel.text = "Php\(Cart.currentCart.getTotal())"
    }
    
    
    func getCurrentLocation()
    {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            self.mapView.showsUserLocation = true

            
        }
        
        
    }
    
    
    @IBAction func addPayment()
    {
        if addressTextField.text == "" {
            let alertController = UIAlertController(title: "Oops!", message: "Please add your shipping address", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Okay!", style: .default) { (action) in
                self.addressTextField.becomeFirstResponder()
                
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion:  nil)
        } else {
            Cart.currentCart.address = addressTextField.text
            self.performSegue(withIdentifier: "AddPayment", sender: self)
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
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath) as! CartItemCell
        
        cell.cartItem = cartItems[indexPath.row]
        
        return cell
    }
}


// MARK: - Location Service

extension CartViewController : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last as! CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpanMake(0.01, 0.01))
        self.mapView.setRegion(region, animated: true)
        
        
        
    }
}

extension CartViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let address = textField.text
        let geocode = CLGeocoder()
        Cart.currentCart.address = address
        geocode.geocodeAddressString(address!) { (placemarks, error) in
            if error != nil {
                print("error translating location into placemark", error)
            }
            if let placemark = placemarks?.first {
                let coordinate = placemark.location!.coordinate
                let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpanMake(0.01, 0.01))
            
            }
        }
        
        
    }
}
