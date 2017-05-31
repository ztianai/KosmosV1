//
//  AddItemViewController.swift
//  Kosmos
//
//  Created by MAIN on 05.05.17.
//  Copyright © 2017 Zhao Tianai. All rights reserved.
//

import UIKit
import Foundation

class AddItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemBrandAndType: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var ingrTableView: UITableView!
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var expirationDate: UILabel!
    
    
    var itemInfo = [String]()
    
    var ingredients = [String]()
    var newItem: ProductItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Item"
        self.navigationController?.navigationBar.isTranslucent = false
        let saveItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(saveItemTap(sender:)))
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1.0, green: 140.0/255, blue: 140.0/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = saveItem
        
        self.itemName.text = itemInfo[1]
        self.itemBrandAndType.text = itemInfo[0] + " | " + itemInfo[2]
        self.itemImageView.image = UIImage(named: itemInfo[0])
        
        let ingredientString = itemInfo[3]
        ingredients = ingredientString.components(separatedBy: ", ")
        
        newItem = ProductItem(barcode: itemInfo[4], name: itemInfo[1], brand: itemInfo[0], type: itemInfo[2], ingredients: ingredients, eDate: "")
        
        print(newItem!.name + " " + (newItem?.barcode)!)
        ingrTableView.delegate = self
        ingrTableView.dataSource = self
        ingrTableView.allowsSelection = false
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddItemViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func todayDate(sender: UIBarButtonItem) {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        dateTextField.text = formatter.string(from: NSDate() as Date)
        let currentDate = NSDate() as Date
        var dateComponent = DateComponents()
        dateComponent.year = 1
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        expirationDate.text = formatter.string(from: futureDate!)
        dateTextField.resignFirstResponder()
    }
    
    func doneDate(sender: UIBarButtonItem) {
        dateTextField.resignFirstResponder()
    }
    
    @IBAction func openDateEdit(_ sender: UITextField) {
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(AddItemViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        toolbar.barStyle = UIBarStyle.blackTranslucent
        toolbar.tintColor = UIColor.white
        
        let todayButton = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(AddItemViewController.todayDate(sender:)))
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(AddItemViewController.doneDate(sender:)))
        
        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/3, height: 40))
        
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = "Select a Date"
        
        let labelButton = UIBarButtonItem(customView: label)
        
        toolbar.setItems([todayButton, flexButton, labelButton, flexButton, doneButton], animated: true)
        dateTextField.inputAccessoryView = toolbar
        
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        let currentDate = sender.date
        var dateComponent = DateComponents()
        dateComponent.year = 1
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        dateTextField.text = dateFormatter.string(from: currentDate)
        expirationDate.text = dateFormatter.string(from: futureDate!)
    }

    
    
    @IBAction func moreInfoTap(_ sender: Any) {
        let alert = UIAlertController(title: "Our Scale", message: "We use an A-F safety rating system\n(A safe, F very unsafe)", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {(alert: UIAlertAction!) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(ingredients.count)
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath as IndexPath)
        cell.textLabel?.text = ingredients[indexPath.item]
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    func saveItemTap(sender: Any?) {
        let defaults = UserDefaults.standard
        let allergies = defaults.object(forKey: "allergies") as? [String]
        var count = 0
        var conflicts = ""
        for allergen in allergies! {
            for item in ingredients {
                if allergen.caseInsensitiveCompare(item) == .orderedSame {
                    count += 1
                    conflicts = conflicts + allergen + ", "
                }
            }
        }
        if conflicts.characters.count > 2 {
            let index = conflicts.index(conflicts.startIndex, offsetBy: conflicts.characters.count - 2)
            conflicts = conflicts.substring(to: index)
            
            let alert = UIAlertController(title: "There were \(count) ingredient conflicts with your allergies", message: "Conflicts: \(conflicts) \nDo you still wantt to add this item?", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in
            }))
            alert.addAction(UIAlertAction(title: "Add Item", style: UIAlertActionStyle.default, handler: { (alert) in
                print("added")
                self.saveItem(item: self.newItem!)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController")
                self.present(vc!, animated: true, completion: nil)
            }))
            
            
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Your item was added to your collection! ", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (alert) in
                print("added")
                self.saveItem(item: self.newItem!)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController")
                self.present(vc!, animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func saveItem(item: ProductItem) {
        item.eDate = expirationDate.text!
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "itemList") != nil {
            let decoded  = defaults.object(forKey: "itemList") as! Data
            var itemDict = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [String: ProductItem]
            itemDict[item.barcode] = item
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: itemDict)
            defaults.set(encodedData, forKey: "itemList")
            defaults.synchronize()
        } else {
            var itemDict = [String: ProductItem]()
            itemDict[item.barcode] = item
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: itemDict)
            defaults.set(encodedData, forKey: "itemList")
            defaults.synchronize()
        }
    }
    
}
