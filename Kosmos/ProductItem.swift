//
//  ProductItem.swift
//  Kosmos
//
//  Created by MAIN on 05.30.17.
//  Copyright © 2017 Zhao Tianai. All rights reserved.
//

import Foundation
import UIKit

class ProductItem {
    
    var barcode: String
    var name: String
    var brand: String
    var type: String
    var ingredients: [String] = []
    
    
    init(barcode: String, name: String, brand: String, type: String, ingredients: [String]) {
        self.name = name
        self.brand = brand
        self.barcode = barcode
        self.type = type
        self.ingredients = ingredients
    }
}
