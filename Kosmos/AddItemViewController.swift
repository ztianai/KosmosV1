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
    
    var itemInfo = [String]()
    
    var ingredients = [String]()
    var newItem: ProductItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Item"
        let saveItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(saveItemTap(sender:)))
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1.0, green: 140.0/255, blue: 140.0/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = saveItem
        
        self.itemName.text = itemInfo[1]
        self.itemBrandAndType.text = itemInfo[0] + " | " + itemInfo[2]
        self.itemImageView.image = #imageLiteral(resourceName: "handcream")
        
        let ingredientString = itemInfo[3]
        ingredients = ingredientString.components(separatedBy: ", ")
        
        newItem = ProductItem(barcode: itemInfo[4], name: itemInfo[1], brand: itemInfo[0], type: itemInfo[2], ingredients: ingredients)
        ingrTableView.delegate = self
        ingrTableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath as IndexPath)
        cell.textLabel?.text = ingredients[indexPath.item]
        return cell
    }
    
    func saveItemTap(sender: Any?) {
        let alert = UIAlertController(title: "Your item was added to your collection! ", message: "not really because this functionality doesn't exist yet, but it will soon!", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (alert) in
            self.saveItem(item: self.newItem!)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveItem(item: ProductItem) {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "itemList") != nil {
            var itemDict = defaults.object(forKey: "itemList") as? [String: ProductItem]
            itemDict?[item.barcode] = item
            defaults.set(itemDict, forKey: "itemList")
            defaults.synchronize()
        } else {
            var itemDict = [String: ProductItem]()
            itemDict[item.barcode] = item
            defaults.set(itemDict, forKey: "itemList")
            defaults.synchronize()
        }
    }
    
}
