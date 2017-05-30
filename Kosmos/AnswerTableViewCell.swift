//
//  AnswerTableViewCell.swift
//  Kosmos
//
//  Created by Zhao Tianai on 2017/4/6.
//  Copyright © 2017年 Zhao Tianai. All rights reserved.
//

import UIKit
class AnswerTableViewCell : UITableViewCell {
    var isObserving = false
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    class var expandedHeight: CGFloat{ get {return 250}}
    class var defaultHeight: CGFloat{get {return 100}}
    
    func checkHeight(){
        answerLabel.isHidden = (frame.size.height < AnswerTableViewCell.expandedHeight)
    }
    
    func watchFrameChanges(){
        if !isObserving {
            addObserver(self, forKeyPath: "frame", options: [.new, .initial], context: nil)
            isObserving = true
        }
        
    }
    
    func ignoreFrameChanges() {
        if isObserving {
            removeObserver(self, forKeyPath: "frame")
            isObserving = false
        }
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
}
