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
    @IBOutlet weak var ageLabel: UILabel!
    
    var allergies = [String]()
    
    @IBOutlet weak var allergyTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadDefaults()
        self.title = "User"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1.0, green: 140.0/255, blue: 140.0/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        let settings = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(touchSettings(sender:)))
        self.navigationItem.rightBarButtonItem = settings
        
        allergyTableView.delegate = self
        allergyTableView.dataSource = self
        allergyTableView.allowsSelection = false
        allergyTableView.tableFooterView = UIView()
        circleImage()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allergies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath as IndexPath)
        cell.textLabel?.text = allergies[indexPath.item]
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }

    
    func circleImage() {
        self.profileImageView.contentMode = .scaleAspectFit
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2
        self.profileImageView.clipsToBounds = true
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
    
    func addAllergies() {
        let alertMenu = UIAlertController(title: "", message: "Please enter any additional allergies (commma separated for multiple)", preferredStyle: .alert)
        
        alertMenu.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "allergies"
            textField.textAlignment = .center
        })
        
        alertMenu.addAction(UIAlertAction(title: "Done", style: .default, handler: { (alert) in
            let allergiesString = alertMenu.textFields![0].text
            let defaults = UserDefaults.standard
            let allergies = defaults.object(forKey: "allergies") as? [String]
            var allergiesList = [String]()
            for allergen in allergies! {
                allergiesList.append(allergen)
            }
            for k in (allergiesString?.components(separatedBy: ","))! {
                let item = k.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                allergiesList.append(item)
            }
            defaults.set(allergiesList, forKey: "allergies")
            defaults.synchronize()
            self.loadDefaults()
            self.allergyTableView.reloadData()
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
        if defaults.object(forKey: "profilePic") != nil {
            let retrievedImage = defaults.object(forKey: "profilePic") as AnyObject
            profileImageView.image = UIImage(data: (retrievedImage as! NSData) as Data)
        }
        nameLabel.text = defaults.object(forKey: "name") as? String
        ageLabel.text = defaults.object(forKey: "age") as? String
        let ingredientList = defaults.object(forKey: "allergies") as? [String]
        for ingredient in ingredientList! {
            allergies.append(ingredient)
        }
    }
    
    func touchSettings(sender: Any?) {
        let optionMenu = UIAlertController(title: "Settings", message: nil, preferredStyle: .actionSheet)
        
        let changeNameAction = UIAlertAction(title: "Add Allergies", style: .default, handler: {(action) in
            self.addAllergies()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in
            print("cancelled")
        })
        
        optionMenu.addAction(changeNameAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
//    @IBAction func touchSettings(_ sender: Any) {
//        let optionMenu = UIAlertController(title: "Settings", message: nil, preferredStyle: .actionSheet)
//        
//        let changeNameAction = UIAlertAction(title: "Change Name", style: .default, handler: {(action) in
//            self.changeName()
//        })
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in
//            print("cancelled")
//        })
//        
//        optionMenu.addAction(changeNameAction)
//        optionMenu.addAction(cancelAction)
//        self.present(optionMenu, animated: true, completion: nil)
//    }
    
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
