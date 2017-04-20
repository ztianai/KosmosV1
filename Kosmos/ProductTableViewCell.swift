//
//  ProduceTableViewCell.swift
//  Kosmos
//
//  Created by Zhao Tianai on 2017/4/5.
//  Copyright © 2017年 Zhao Tianai. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
