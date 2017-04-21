//
//  ScanViewController.swift
//  Kosmos
//
//  Created by Zhao Tianai on 2017/4/20.
//  Copyright © 2017年 Zhao Tianai. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ProductViewController: UIViewController {

    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var brandNameLabel: UILabel!

    var searchText: String?
    var ref:FIRDatabaseReference?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(searchText)
        ref = FIRDatabase.database().reference()
        ref?.child("Products").queryOrdered(byChild: "name").queryEqual(toValue: searchText).observe(FIRDataEventType.value, with: { (snapshot) in
            
            for snap in snapshot.children {
                let snapDataSnapshot = snap as! FIRDataSnapshot
//                for s in snapDataSnapshot.children{
//                    let productName = (s.value as? NSDictionary)?["name"] as? String ?? ""
//                    print(productName)
//                }
                let snapValues = snapDataSnapshot.value as? [String: AnyObject]
                let productName = snapValues?["name"] as? String
                let brandName = snapValues?["brand"] as? String
                self.brandNameLabel.text = brandName
                self.productNameLabel.text = productName
                print(productName)
                
                
            }
        })
            
            
//        query?.observe(FIRDataEventType.value, with: { (snapshot) in
//            //let title = snapshot.value["Name"] as! [String: AnyObject]
//            let productName = (snapshot.value as? NSDictionary)?["name"] as? String ?? ""
//            let brandName = (snapshot.value as? NSDictionary)?["brand"] as? String ?? ""
//            
//            //print(title)
//            self.productNameLabel.text = productName
//            self.brandNameLabel.text = brandName
//        })
//        ref?.child("Products").child("Product2").observe(FIRDataEventType.value, with: { (snapshot) in
//            //let title = snapshot.value["Name"] as! [String: AnyObject]
//            let productName = (snapshot.value as? NSDictionary)?["name"] as? String ?? ""
//            let brandName = (snapshot.value as? NSDictionary)?["brand"] as? String ?? ""
//
//            //print(title)
//            self.productNameLabel.text = productName
//            self.brandNameLabel.text = brandName
//        })
        
        
        
        //myRef.queryOrderedByChild("domain").queryEqualToValue("yourDomainSearchValue")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
