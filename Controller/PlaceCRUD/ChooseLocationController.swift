//
//  ChooseLocationController.swift
//  FoursquareClone
//
//  Created by Selim on 28.09.2024.
//

import UIKit
import MapKit
import Parse

class ChooseLocationController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    var placeName : String = ""
    var placeType : String = ""
    var placeAtmosphere : String = ""
    var selectedImage = UIImage()
    
    var choosenLongitude = Double()
    var choosenLatitude = Double()
    
    var count = 0
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var _error = ErrorMiddleWare()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        mapView.delegate = self
        
        // Provides the best location as possible
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // Allows the application to obtain access to location data from the user
        locationManager.requestWhenInUseAuthorization()
        //with that line, app always getting location changes
        locationManager.startUpdatingLocation()
        
        let longGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        longGestureRecognizer.minimumPressDuration = 2
        mapView.addGestureRecognizer(longGestureRecognizer)
        
    }
 
    override func viewDidAppear(_ animated: Bool) {
        
        let saveButton: ()? = navigationController?.navigationBar.topItem?.rightBarButtonItem =
        UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save
                        , target: self, action: #selector(saveButtonClicked))
    }
    
    
    //add marker on map with annotation
    @objc func chooseLocation(gestureRecognizer:UIGestureRecognizer){
        if gestureRecognizer.state == .began{
            count = 1
            let touchedPoint = gestureRecognizer.location(in: mapView)
            let touchedCoordinate = mapView.convert(touchedPoint, toCoordinateFrom: mapView)
            choosenLatitude = touchedCoordinate.latitude
            choosenLongitude = touchedCoordinate.longitude
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinate
            annotation.title = placeName
            annotation.subtitle = placeType
            mapView.addAnnotation(annotation)
        }
    }

    
    //Zoom for the user's current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
            let locations = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07)
        
            let region = MKCoordinateRegion(center: locations, span: span)
            
            mapView.setRegion(region, animated: true)
        
    }
    
    

    
    
    @objc func saveButtonClicked(){
        
        if count != 0 {
            
            do {
                let place = PFObject(className: "places")
                place["placeName"] = self.placeName
                place["placeType"] = self.placeType
                place["placeAtmosphere"] = self.placeAtmosphere
            
            let imageData = selectedImage.jpegData(compressionQuality: 0.8)
            let imageFile = try PFFileObject(name: "\(placeName)", data: imageData!, contentType: "image/jpeg")
                place["image"] = imageFile
            
            
                place["choosenLatitude"] = self.choosenLatitude
                    place["choosenLongitude"] = self.choosenLongitude
            
                    place.saveInBackground { success, error in
                    if success {
                        self.performSegue(withIdentifier: "backToPlaceList", sender: self)
                        
                    }
                    
                    else {
                        self._error.showError(_title: "Something wen't wrong", _message: error!.localizedDescription)
                    }
                }
            }
            catch {
                _error.showError(_title: "Something wen't wrong", _message: "Plase try again later")
            }
                
        }
    }
    
}
