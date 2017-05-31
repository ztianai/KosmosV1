//
//  ProductViewController.swift
//  Kosmos
//
//  Created by MAIN on 05.31.17.
//  Copyright © 2017 Zhao Tianai. All rights reserved.
//

import UIKit
import Foundation

class ProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var product: ProductItem?
    
//    var barcode: String?
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemBrandAndType: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var expirationDate: UILabel!
    
    @IBOutlet weak var ingrTableView: UITableView!
    
//    var barcodeString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if barcodeString != nil {
//            self.barcodeString = barcode!;
//        }
//        let defaults = UserDefaults.standard
//        let decoded  = defaults.object(forKey: "itemList") as! Data
//        var itemDict = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [String: ProductItem]
//        product = itemDict[barcodeString]
        
        self.title = (product?.brand)! + " " + (product?.name)!
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1.0, green: 140.0/255, blue: 140.0/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        
        self.itemName.text = self.product?.name
        self.itemBrandAndType.text = (self.product?.brand)! + " | " + (product?.type)!
        self.itemImageView.image = UIImage(named: (self.product?.brand)!)
        self.todayDate.text = todaysDate()
        if (self.product?.eDate.characters.count)! > 2 {
            self.expirationDate.text = self.product?.eDate
        } else {
            self.expirationDate.text = "hm"
        }
        
        ingrTableView.delegate = self
        ingrTableView.dataSource = self
        ingrTableView.allowsSelection = false
        
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddItemViewController.dismissKeyboard))
//        view.addGestureRecognizer(tap)
    }
    
    //    func dismissKeyboard() {
    //        view.endEditing(true)
    //    }
    
    func todaysDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        return formatter.string(from: NSDate() as Date)
    }
    
    @IBAction func showOurScales(_ sender: Any) {
        let alert = UIAlertController(title: "Our Scale", message: "We use an A-F safety rating system\n(A safe, F very unsafe)", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {(alert: UIAlertAction!) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product!.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath as IndexPath)
        cell.textLabel?.text = product?.ingredients[indexPath.item]
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
}
