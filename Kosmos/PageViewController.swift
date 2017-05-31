//
//  PageViewController.swift
//  Kosmos
//
//  Created by MAIN on 05.31.17.
//  Copyright © 2017 Zhao Tianai. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let firstVC = orderedViewControllers.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVC(name: "on1"), self.newVC(name: "on2"), self.newVC(name: "on3"), self.newVC(name: "on4"), self.newVC(name: "on5")]
    }()
    
    private func newVC(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle:nil) . instantiateViewController(withIdentifier: name)
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let prevIndex = vcIndex - 1
        
        guard prevIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > prevIndex else {
            return nil
        }
        
        
        return orderedViewControllers[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = vcIndex + 1
        let ovcCount = orderedViewControllers.count
        
        guard ovcCount != nextIndex else {
            return nil
        }
        
        guard ovcCount > nextIndex else {
            return nil
        }
        
        
        return orderedViewControllers[nextIndex]
    }
}
