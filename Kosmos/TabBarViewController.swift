//
//  TabBarViewController.swift
//  Kosmos
//
//  Created by Zhao Tianai on 2017/4/13.
//  Copyright © 2017年 Zhao Tianai. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    

    var skinBtn: UIStackView!
    var makeupBtn: UIStackView!
    var hairBtn: UIStackView!
    var cancelBtn: UIButton!
    var button: UIButton!
    var searchText: UITextField!
    
    var skinBtnPosY: CGFloat!
    var makeupBtnPosY: CGFloat!
    var hairBtnPosY: CGFloat!
    
    var popView: UIView!
    var blurView: UIView!
    
    let postBtn = UIButton()
    
    var flag = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let WINDOW_HEIGHT = self.view.frame.height
        let TAB_HEIGHT = self.tabBar.frame.height
        let GRID_WIDTH = self.view.frame.width / 5
        let MARGIN_X = CGFloat(2)
//        let MARGIN_Y = CGFloat(5)
        let BTN_WIDTH = TAB_HEIGHT - MARGIN_X * 2
//        let BTN_HEIGHT = TAB_HEIGHT - MARGIN_Y * 2
        
        let modalView = UIView()
        modalView.frame = CGRect(x: GRID_WIDTH * 2, y: WINDOW_HEIGHT - TAB_HEIGHT, width: GRID_WIDTH, height: TAB_HEIGHT)
        self.view.addSubview(modalView)
        
//        let postBtn = UIButton()
        postBtn.frame = CGRect(x: GRID_WIDTH * 2 + BTN_WIDTH / 2 - MARGIN_X * 3, y: WINDOW_HEIGHT - TAB_HEIGHT - TAB_HEIGHT / 3, width: BTN_WIDTH + MARGIN_X * 2, height: BTN_WIDTH + MARGIN_X * 2)
        postBtn.setBackgroundImage(UIImage(named: "post_btn"), for: UIControlState())
        self.view.addSubview(postBtn)
        
        postBtn.addTarget(self, action: #selector(TabBarViewController.postButtonClicked(_:)), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    
    func showPostButton(show: Bool) {
        postBtn.isHidden = !show
    }
    
    func postButtonClicked(_ sender: UIButton) {
        print("button was pressed")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController")
        self.present(vc!, animated: false, completion: nil)
//        self.tabBarController?.selectedIndex = 0
//        if !flag {
//            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
//            let blurView = UIVisualEffectView(effect: blurEffect)
//            blurView.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height)
//            self.view.addSubview(blurView)
//            
//            self.blurView = blurView
//            
//            let ASVC = self.storyboard?.instantiateViewController(withIdentifier: "AddSelection") as! AddSelectionViewController
//            ASVC.modalTransitionStyle = .crossDissolve
//            self.view.addSubview(ASVC.view)
//
//            self.skinBtn = ASVC.skinBtn
//            self.makeupBtn = ASVC.makeupBtn
//            self.hairBtn = ASVC.hairBtn
//            self.cancelBtn = ASVC.cancelBtn
//            self.button = ASVC.button
//            self.searchText = ASVC.searchText
//            
//            self.skinBtnPosY = ASVC.skinBtn.frame.origin.y
//            self.makeupBtnPosY = ASVC.makeupBtn.frame.origin.y
//            self.hairBtnPosY = ASVC.hairBtn.frame.origin.y
//
//            
//            self.popView = ASVC.view
//            
//            self.popView.alpha = 0
//            self.blurView.alpha = 0
//            
//            self.cancelBtn!.addTarget(self, action: #selector(TabBarViewController.cancelBtnPressed(_:)), for: .touchUpInside)
//            self.button!.addTarget(self, action: #selector(TabBarViewController.buttonPressed(_:)), for: .touchUpInside)
//            
//            self.flag = true
//        }
        
//        UIView.animate(withDuration: 0.7, animations: { () -> Void in
//            
//            self.cancelBtn.transform = CGAffineTransform(rotationAngle: .pi/2)
//            self.popView.alpha = 1
//            self.blurView.alpha = 1
//        })
        
        
//        let WINDOW_HEIGHT = self.view.frame.height
//        let BTN_HEIGHT = self.skinBtn.frame.height
//        self.skinBtn.frame.origin.y = WINDOW_HEIGHT
//        self.makeupBtn.frame.origin.y = WINDOW_HEIGHT
//        self.hairBtn.frame.origin.y = WINDOW_HEIGHT
        
    }
    
    
    func buttonPressed(_ sender: UIButton) {
        print("something")
        //        print("boo")
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "scanSelect") as! ProductViewController
//        vc.searchText = self.searchText.text
//        self.present(vc, animated: true, completion: nil)
       //  self.blurView.alpha = 0
       // self.popView.alpha = 0
       // self.performSegue(withIdentifier: "scanSelection", sender: self)
    }
    
    func cancelBtnPressed(_ sender: UIButton) {
//        UIView.animate(withDuration: 1.3, animations: { () -> Void in
//            self.blurView.alpha = 0
//            self.popView.alpha = 0
//            self.cancelBtn.transform = CGAffineTransform(rotationAngle: CGFloat(0))
//        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
