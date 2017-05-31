//
//  ProductItem.swift
//  Kosmos
//
//  Created by MAIN on 05.30.17.
//  Copyright © 2017 Zhao Tianai. All rights reserved.
//

import Foundation
import UIKit

class ProductItem: NSObject, NSCoding {
    
    var barcode: String
    var name: String
    var brand: String
    var type: String
    var ingredients = [String]()
    var eDate: String
    
    init(barcode: String, name: String, brand: String, type: String, ingredients: [String], eDate: String) {
        self.name = name
        self.brand = brand
        self.barcode = barcode
        self.type = type
        self.ingredients = ingredients
        self.eDate = eDate
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let barcode = aDecoder.decodeObject(forKey: "barcode") as! String
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let brand = aDecoder.decodeObject(forKey: "brand") as! String
        let type = aDecoder.decodeObject(forKey: "type") as! String
        let ingredients = aDecoder.decodeObject(forKey: "ingredients") as! [String]
        let eDate = aDecoder.decodeObject(forKey: "eDate") as! String
        self.init(barcode: barcode, name: name, brand: brand, type: type, ingredients: ingredients, eDate: eDate)
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(barcode, forKey: "barcode")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(brand, forKey: "brand")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(ingredients, forKey: "ingredients")
        aCoder.encode(eDate, forKey: "eDate")
    }
}
