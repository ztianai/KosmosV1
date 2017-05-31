//
//  NewUserViewController.swift
//  Kosmos
//
//  Created by MAIN on 05.31.17.
//  Copyright © 2017 Zhao Tianai. All rights reserved.
//

import UIKit

class NewUserViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var uploadLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var allergies: UITextView!
    
    @IBOutlet weak var profileImageView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.layer.cornerRadius = 20
        self.title = "User"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1.0, green: 140.0/255, blue: 140.0/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        
        self.ageTextField.delegate = self
        self.nameTextField.delegate = self
        
        self.ageTextField.keyboardType = .numberPad
        self.allergies.layer.borderWidth = 1
        self.allergies.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewUserViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func changeProfilePicture(_ sender: Any) {
        let optionMenu = UIAlertController(title: "Change Profile Picture", message: nil, preferredStyle: .actionSheet)
        
        let newPhotoAction = UIAlertAction(title: "Take Photo", style: .default, handler: {(action) in
            self.takePhoto()
        })
        
        let importPhotoAction = UIAlertAction(title: "Choose from Library", style: .default, handler: {(action) in
            self.openCameraRoll()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in
            print("cancelled")
        })
        
        optionMenu.addAction(newPhotoAction)
        optionMenu.addAction(importPhotoAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
        circleImage()
    }
    func circleImage() {
        self.profileImageView.contentMode = .scaleAspectFit
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2
        self.profileImageView.clipsToBounds = true
        self.uploadLabel.isHidden = true
    }
    
    func takePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            profileImageView.contentMode = .scaleAspectFit
            profileImageView.image = pickedImage
            let pngImage = UIImagePNGRepresentation(pickedImage)
            let defaults = UserDefaults.standard
            defaults.set(pngImage, forKey: "profilePic")
            defaults.synchronize()
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func openCameraRoll() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    @IBAction func startApp(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "onboarding")
        defaults.set(self.nameTextField.text, forKey: "name")
        defaults.set(self.ageTextField.text, forKey: "age")
        if let allergiesText = self.allergies.text {
            let ingredientList = allergiesText.components(separatedBy: ",")
            var allergiesList = [String]()
            for ingredient in ingredientList {
                let item = ingredient.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                allergiesList.append(item)
            }

            
            defaults.set(allergiesList, forKey: "allergies")
        } else {
            defaults.set([""], forKey: "allergies")
        }
        defaults.synchronize()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController")
        self.present(vc!, animated: false   , completion: nil)
    }
    
    
    
}
