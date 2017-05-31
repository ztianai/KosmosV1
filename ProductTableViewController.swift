//
//  ProductTableViewController.swift
//  Kosmos
//
//  Created by Zhao Tianai on 2017/4/5.
//  Copyright © 2017年 Zhao Tianai. All rights reserved.
//

import UIKit
import os.log

class ProductTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var products = [ProductItem]()
    let defaults = UserDefaults.standard

    @IBOutlet weak var numProducts: UILabel!
    @IBOutlet weak var productTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Collection"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1.0, green: 140.0/255, blue: 140.0/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        if defaults.object(forKey: "itemList") != nil {
            let decoded  = defaults.object(forKey: "itemList") as! Data
            let itemDict = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [String: ProductItem]
            self.products.removeAll()
            for (_, value) in itemDict {
                print(value)
                self.products.append(value)
            }
            self.numProducts.text = String(products.count)
            self.productTableView.reloadData()
        }
        
        
        
        self.productTableView.delegate = self
        self.productTableView.dataSource = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.productTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let barcode = products[indexPath.row].barcode
            if defaults.object(forKey: "itemList") != nil {
                let decoded  = defaults.object(forKey: "itemList") as! Data
                var itemDict = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [String: ProductItem]
                itemDict.removeValue(forKey: barcode)
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: itemDict)
                defaults.set(encodedData, forKey: "itemList")
                defaults.synchronize()
            }
            self.products.remove(at: indexPath.row)
            self.numProducts.text = String(products.count)
            self.productTableView.reloadData()
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath as IndexPath)
        
        let product = products[indexPath.row]
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = product.brand
        return cell
    }

}
