//
//  PlacesListController.swift
//  FoursquareClone
//
//  Created by Selim on 26.09.2024.
//

import UIKit
import Parse
import CoreData

class ListPlacesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var _error = ErrorMiddleWare()
    
    var nameArray = [String]()
    var typeArray = [String]()
    var atmosphereArray = [String]()
    var imageArray = [UIImage]()
    var latitudeArray = [Double]()
    var longitudeArray = [Double]()
    
    var selectedName = ""
    var selectedType = ""
    var selectedAtmosphere = ""
    var selectedImage = UIImage()
    var selectedLatitude = Double()
    var selectedLongitude = Double()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "placeCell")

        
        // Logout button on the navigation bar
        let logoutButton = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logOut))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = logoutButton
        
        // Add place button on the navigation bar
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createPlace))
        navigationController?.navigationBar.topItem?.rightBarButtonItem = addButton
        
        // Fetch the data from Parse
        GetData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Listen for new data updates
        NotificationCenter.default.addObserver(self, selector: #selector(GetData), name: NSNotification.Name("newData"), object: nil)
    }
    
    @objc func GetData(){
        // Clear the arrays before fetching new data
        nameArray.removeAll(keepingCapacity: false)
        typeArray.removeAll(keepingCapacity: false)
        atmosphereArray.removeAll(keepingCapacity: false)
        latitudeArray.removeAll(keepingCapacity: false)
        longitudeArray.removeAll(keepingCapacity: false)
        imageArray.removeAll(keepingCapacity: false)
        
        let placesQuery = PFQuery(className: "places")
        
        placesQuery.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                self._error.showError(_title: "Something went wrong", _message: error.localizedDescription)
                print(error.localizedDescription)
            } else if let objects = objects {
                print("Objects fetched successfully")
                
                // Parse the data
                for object in objects {
                    if let name = object["placeName"] as? String {
                        self.nameArray.append(name)
                    }
                    if let type = object["placeType"] as? String {
                        self.typeArray.append(type)
                    }
                    if let atmosphere = object["placeAtmosphere"] as? String {
                        self.atmosphereArray.append(atmosphere)
                    }
                    if let latitude = object["choosenLatitude"] as? Double {
                        self.latitudeArray.append(latitude)
                    }
                    if let longitude = object["choosenLongitude"] as? Double {
                        self.longitudeArray.append(longitude)
                    }
                    if let image = object["image"] as? PFFileObject {
                        image.getDataInBackground { (imageData: Data?, error: Error?) in
                            if let error = error {
                                self._error.showError(_title: "Something went wrong", _message: error.localizedDescription)
                            } else if let imageData = imageData, let image = UIImage(data: imageData) {
                                self.imageArray.append(image)
                            }
                        }
                    }
                }
                
                // Reload the tableView after data is fetched
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    
    @objc func createPlace() {
        performSegue(withIdentifier: "toCreatePLaceVC", sender: self)
    }
    
    @objc func logOut() {
        PFUser.logOutInBackground { error in
            if let error = error {
                self._error.showError(_title: "Something went wrong", _message: error.localizedDescription)
            } else {
                // Remove saved user data
                UserDefaults.standard.removeObject(forKey: "userName")
                UserDefaults.standard.removeObject(forKey: "password")
                UserDefaults.standard.setValue(false, forKey: "isLoggedIn")
                
                // Go back to sign in screen
                self.performSegue(withIdentifier: "toSignInBackVC", sender: self)
            }
        }
    }
    
    // MARK: - UITableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Reuse a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = nameArray[indexPath.row]
        content.secondaryText = typeArray[indexPath.row]
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedName = nameArray[indexPath.row]
        selectedType = typeArray[indexPath.row]
        selectedAtmosphere = atmosphereArray[indexPath.row]
        selectedLatitude = latitudeArray[indexPath.row]
        selectedLongitude = longitudeArray[indexPath.row]
        selectedImage = imageArray[indexPath.row]
        
        performSegue(withIdentifier: "toDetailVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC"{
            let controller = segue.destination as! PlaceDetailController
            controller.selectedName = selectedName
            controller.selectedType = selectedType
            controller.selectedAtmosphere = selectedAtmosphere
            controller.selectedImage = selectedImage
            controller.selectedLatitude = selectedLatitude
            controller.selectedLongitude = selectedLongitude
        }
    }
    
}

