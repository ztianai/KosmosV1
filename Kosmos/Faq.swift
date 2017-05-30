//
//  Faq.swift
//  
//
//  Created by Zhao Tianai on 2017/5/29.
//
//

import UIKit
class Faq {
    //MARK: Properties
    var question : String
    var answer : String
    
    init?(question: String, answer: String) {
        guard !question.isEmpty else{
            return nil
        }
        
        guard !answer.isEmpty else{
            return nil
        }
        self.question = question
        self.answer = answer
    }
}
