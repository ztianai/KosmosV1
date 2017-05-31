//
//  AccountViewController.swift
//  Kosmos
//
//  Created by MAIN on 04.20.17.
//  Copyright © 2017 Zhao Tianai. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    let allergies = ["formaldehyde", "phenoxyethanol", "amidoamine"]
    
    @IBOutlet weak var allergyTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadDefaults()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1.0, green: 140.0/255, blue: 140.0/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        allergyTableView.delegate = self
        allergyTableView.dataSource = self
        circleImage()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allergies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath as IndexPath)
        cell.textLabel?.text = allergies[indexPath.item]
        return cell
    }

    
    func circleImage() {
        self.profileImageView.contentMode = .scaleAspectFit
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2
        self.profileImageView.clipsToBounds = true
//        profileImageView.layer.masksToBounds = false
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
    
    func changeName() {
        let alertMenu = UIAlertController(title: "", message: "Please enter your name", preferredStyle: .alert)
        
        alertMenu.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "Your Name"
            textField.textAlignment = .center
        })
        
        alertMenu.addAction(UIAlertAction(title: "Done", style: .default, handler: { (alert) in
            let nameString = alertMenu.textFields![0].text
            self.setName(name: nameString!)
            self.loadDefaults()
        }))
        
        alertMenu.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in
            print("cancelled")
        }))
        
        self.present(alertMenu, animated: true, completion: nil)
    }
    
    func setName(name: String) {
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: "userName")
        defaults.synchronize()
    }
    
    func loadDefaults() {
        let defaults = UserDefaults.standard
        nameLabel.text = defaults.object(forKey: "userName") as? String
    }
    
    @IBAction func touchSettings(_ sender: Any) {
        let optionMenu = UIAlertController(title: "Settings", message: nil, preferredStyle: .actionSheet)
        
        let changeNameAction = UIAlertAction(title: "Change Name", style: .default, handler: {(action) in
            self.changeName()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in
            print("cancelled")
        })
        
        optionMenu.addAction(changeNameAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func changeProPic(_ sender: Any) {
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

}
