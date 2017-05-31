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
    var product: ProductItem?
//    var days2 = 0.0

    @IBOutlet weak var onbView: UIView!
    @IBOutlet weak var numProducts: UILabel!
    @IBOutlet weak var productTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if defaults.object(forKey: "onboarding") as! Bool == true {
        
//            defaults.set(false, forKey: "onboarding")
//            defaults.synchronize()
//        }

        
        
        self.title = "My Collection"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1.0, green: 140.0/255, blue: 140.0/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let saveItem = UIBarButtonItem(title: "Reset Demo", style: .plain, target: self, action: #selector(resetDemo(sender:)))
        self.navigationItem.rightBarButtonItem = saveItem
        
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
        self.productTableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.productTableView.reloadData()
    }
    
    func resetDemo(sender: Any?) {
        let alert = UIAlertController(title: "Demo will be reset, continue?", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in
        }))
        
        alert.addAction(UIAlertAction(title: "Reset", style: UIAlertActionStyle.default, handler: { (alert) in
            let defaults = UserDefaults.standard
            defaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            defaults.synchronize()
        }))
        self.present(alert, animated: true, completion: nil)
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
        cell.detailTextLabel?.text = product.brand + " | " + product.type
        let currentDate = NSDate() as Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        var days = 0.0
        if product.eDate.characters.count > 0 {
            let eDate = dateFormatter.date(from: product.eDate)
            days = Double(currentDate.days(from: eDate!))
        }
        if days <= -365.0 {
            days = 0
        } else if days < 0.0 {
            days += 365.0
        } else {
            days = 365.0
        }
//        days2 = days
        if days == 365.0 {
            let label = UILabel(frame: CGRect(x: 256, y: 30, width: 120, height: 20))
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor = UIColor(red: 182.0/255, green: 0.0, blue: 53.0/255, alpha: 1.0)
            label.textAlignment = .center
            label.text = "Expired !"
            cell.addSubview(label)
        } else {
            let rect1 = CGRect(x: 280, y: 30, width: 80, height: 10)
            let rect2 = CGRect(x: 280, y: 30, width: 80 - 80 * ((365.0-days)/365.0), height: 10)
            let testView1: UIView = UIView(frame: rect1)
            testView1.backgroundColor = UIColor(red: 239.0/255, green: 239.0/255, blue: 239.0/255, alpha: 1.0)
            let testView2: UIView = UIView(frame: rect2)
            testView2.backgroundColor = UIColor(red: 182.0/255, green: 0.0, blue: 53.0/255, alpha: 1.0)
            
            
            cell.addSubview(testView1)
            cell.addSubview(testView2)
        }
        
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.product = products[indexPath.row]
        self.performSegue(withIdentifier: "collectionToProduct", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "collectionToProduct" {
            let nav = segue.destination as! ProductViewController
//            let destinationVC = nav.topViewController as! ProductViewController
            nav.product = self.product        }
    }
}
