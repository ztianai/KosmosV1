//
//  OnFiveViewController.swift
//  Kosmos
//
//  Created by MAIN on 05.31.17.
//  Copyright © 2017 Zhao Tianai. All rights reserved.
//

import UIKit

class OnFiveViewController: UIViewController {
    
    @IBOutlet weak var goButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goButton.layer.cornerRadius = 20
//        button.layer.borderWidth = 1
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
