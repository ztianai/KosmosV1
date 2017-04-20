//
//  Product.swift
//  Kosmos
//
//  Created by Zhao Tianai on 2017/4/5.
//  Copyright © 2017年 Zhao Tianai. All rights reserved.
//

import UIKit
class Product {
    //MARK: Properties
    var name : String
    var brand : String
    
    init?(name: String, brand: String) {
        guard !name.isEmpty else{
            return nil
        }
        
        guard !brand.isEmpty else{
            return nil
        }
        self.name = name
        self.brand = brand
    }
}
