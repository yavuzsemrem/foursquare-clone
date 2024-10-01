//
//  PlaceDetailController.swift
//  FoursquareClone
//
//  Created by Selim on 29.09.2024.
//

import UIKit
import MapKit

class PlaceDetailController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var placeAtmosphere: UITextField!
    @IBOutlet weak var placeType: UITextField!
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var locationManager = CLLocationManager()
    var selectedLatitude = Double()
    var selectedLongitude = Double()
    var selectedName = ""
    var selectedType = ""
    var selectedAtmosphere = ""
    var selectedImage = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        locationManager.delegate = self
        
        // Provides the best location as possible
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // Allows the application to obtain access to location data from the user
        locationManager.requestWhenInUseAuthorization()
        //with that line, app always getting location changes
        locationManager.startUpdatingLocation()
        
        
        placeName.text = selectedName
        placeType.text = selectedType
        placeAtmosphere.text = selectedAtmosphere
        imageView.image = selectedImage
        
        loadAnnotation()
        
    }
    
    func loadAnnotation(){
        
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = selectedLatitude
        annotation.coordinate.longitude = selectedLongitude
        annotation.title = selectedName
        annotation.subtitle = selectedType
        mapView.addAnnotation(annotation)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = CLLocationCoordinate2D(latitude: selectedLatitude, longitude: selectedLongitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
    }

    
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
            if annotation is MKUserLocation {
                return nil
            }
    
            let reuseId = "myPin"
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKMarkerAnnotationView
    
            if pinView == nil{
    
                pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView?.tintColor = .systemPink
                pinView?.canShowCallout = true
    
    
                let button = UIButton(type: .detailDisclosure)
                pinView?.rightCalloutAccessoryView = button
            }
    
            else {
                pinView?.annotation = annotation
            }
    
            return pinView
        }
    
    
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    
            let location = CLLocation(latitude: selectedLatitude, longitude: selectedLongitude)
            
            CLGeocoder().reverseGeocodeLocation(location) { placeMarks, error in
                if let placeMarks = placeMarks{
                    if placeMarks.count > 0 {
                        let newPlaceMark = MKPlacemark(placemark: placeMarks[0])
                        let mapItem = MKMapItem(placemark: newPlaceMark)
                        mapItem.name = self.selectedName
                        
                        let options = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                        
                        mapItem.openInMaps(launchOptions: options)
                    }
                }
            }
        }
    

}
