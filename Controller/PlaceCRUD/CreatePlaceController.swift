//
//  CreatePlaceController.swift
//  FoursquareClone
//
//  Created by Selim on 28.09.2024.
//

import UIKit
import PhotosUI

class CreatePlaceController: UIViewController, PHPickerViewControllerDelegate {

    @IBOutlet weak var placeAtmosphere: UITextField!
    @IBOutlet weak var placeTypeLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var error = ErrorMiddleWare()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //add action for imageView after touched
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        //make imageView touchable
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
       
    }

    
    @objc func ConfigureImagePicker()
    {
        var configuration = PHPickerConfiguration()
        
        //0 is Unlimited, 1 is Default
        configuration.selectionLimit = 1
        //filters in library just images
        configuration.filter = .images
        
        let pickerController = PHPickerViewController(configuration: configuration)
        pickerController.delegate = self
        present(pickerController, animated: true)
    }
    
    @objc func pickImage(){
        ConfigureImagePicker()
    }
    
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      //it's shows animation after picked image
        picker.dismiss(animated: true)
        
        if let itemProvider = results.first?.itemProvider {
            
          if itemProvider.canLoadObject(ofClass: UIImage.self){
                
              itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                  if let selectedImage = image as? UIImage {
                      
                      // the codes that works on background doesn't affect to UI elements directly
                      // so we should make UI updates in main thread
                      // if we didn't do it there, it'll show the image after controller loads
                      DispatchQueue.main.async {
                          self.imageView.image = selectedImage
                      }
                  }
              }
              
            }
            
        }
    }
    
    
    @IBAction func nexButtonClicked(_ sender: UIButton) {
        
        guard let _image =  imageView.image,
             let _place = placeTypeLabel.text, !_place.isEmpty,
             let _name = nameLabel.text, !_name.isEmpty,
              let _placeAtmosphere = placeAtmosphere.text, !_placeAtmosphere.isEmpty else
        {
            self.error.showError(_title: "Eksik Bilgi", _message: "Tüm alanları doldurunuz")
            return
        }
        
        performSegue(withIdentifier: "toChooseLocationVC", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChooseLocationVC" {
            let controller = segue.destination as! ChooseLocationController
            controller.placeName = nameLabel.text!
            controller.placeType = placeTypeLabel.text!
            controller.placeAtmosphere = placeAtmosphere.text!
            controller.selectedImage = imageView.image!
        }
    }
    
    
}
