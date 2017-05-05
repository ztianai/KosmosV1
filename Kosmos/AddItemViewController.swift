//
//  AddItemViewController.swift
//  Kosmos
//
//  Created by MAIN on 05.05.17.
//  Copyright © 2017 Zhao Tianai. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemBrandAndType: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var ingrTableView: UITableView!
    
    var itemInfo = [String]()
    
    let ingredients = ["Glycerin", "Dimethicone", "Linseed Extract", "Benzoic Acid", "Linalool", "Butylphenyl", "Polyacrylamide"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Item"
        let saveItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(saveItemTap(sender:)))
//        let saveItem = UIBarButtonItem(barButtonSystemItem: , target: self, action: #selector(saveItemTap(sender:)))
        self.navigationItem.rightBarButtonItem = saveItem
        
        self.itemName.text = itemInfo[1]
        self.itemBrandAndType.text = itemInfo[0] + " | " + itemInfo[2]
        self.itemImageView.image = #imageLiteral(resourceName: "handcream")
        
        
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
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default,handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }

}
