//
//  ScrollViewController.swift
//  Kosmos
//
//  Created by MAIN on 04.27.17.
//  Copyright © 2017 Zhao Tianai. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        
        let scannerVC = self.storyboard?.instantiateViewController(withIdentifier: "scannerID")
        self.addChildViewController(scannerVC!)
        self.scrollView.addSubview(scannerVC!.view)
        scannerVC!.didMove(toParentViewController: self)
        scannerVC!.view.frame = scrollView.bounds
        
        let myColVC = self.storyboard?.instantiateViewController(withIdentifier: "myCollectionID") as UIViewController!
        self.addChildViewController(myColVC!)
        self.scrollView.addSubview(myColVC!.view)
        myColVC!.didMove(toParentViewController: self)
        myColVC!.view.frame = scrollView.bounds
        
        var myColVCFrame: CGRect = myColVC!.view.frame
        myColVCFrame.origin.x = 0
        myColVCFrame.origin.y = self.view.frame.height
        myColVC!.view.frame = myColVCFrame
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height * 2)
        self.scrollView.contentOffset = CGPoint(x: 0, y: self.view.frame.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset.y)
        
//        if scrollView.contentOffset.x != 0 {
//            scrollView.contentOffset.x = 0
//        }
        let tabBar = self.tabBarController as! TabBarViewController

        if scrollView.contentOffset.y > self.view.frame.height - 20 {
            self.tabBarController?.tabBar.isHidden = false
            tabBar.showPostButton(show: true)
        } else {
            self.tabBarController?.tabBar.isHidden = true
            tabBar.showPostButton(show: false)
        }
    }
    
}
