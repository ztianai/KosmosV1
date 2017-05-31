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
//    var days: Double?
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemBrandAndType: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var expirationDate: UILabel!
    
    @IBOutlet weak var ingrTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        var days = 0.0
        let currentDate = NSDate() as Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        if (product?.eDate.characters.count)! > 0 {
            let eDate = dateFormatter.date(from: (product?.eDate)!)
            days = Double(currentDate.days(from: eDate!))
        }
        if days <= -365.0 {
            days = 0
        } else if days < 0.0 {
            days += 365.0
        } else {
            days = 365.0
        }
        
        if days == 365.0 {
            let label = UILabel(frame: CGRect(x: 5, y: 67, width: 120, height: 20))
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor = UIColor(red: 182.0/255, green: 0.0, blue: 53.0/255, alpha: 1.0)
            label.textAlignment = .center
            label.text = "Expired !"
            view.addSubview(label)
        } else {
            let rect1 = CGRect(x: 27, y: 72, width: 120, height: 10)
            let rect2 = CGRect(x: 27, y: 72, width: 120 - 120 * ((365.0-days)/365.0), height: 10)
            let testView1: UIView = UIView(frame: rect1)
            testView1.backgroundColor = UIColor(red: 239.0/255, green: 239.0/255, blue: 239.0/255, alpha: 1.0)
            let testView2: UIView = UIView(frame: rect2)
            testView2.backgroundColor = UIColor(red: 182.0/255, green: 0.0, blue: 53.0/255, alpha: 1.0)
            
            
            view.addSubview(testView1)
            view.addSubview(testView2)
        }

        
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
