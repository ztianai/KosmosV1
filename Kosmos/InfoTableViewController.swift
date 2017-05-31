//
//  InfoTableViewController.swift
//  Kosmos
//
//  Created by Zhao Tianai on 2017/4/6.
//  Copyright © 2017年 Zhao Tianai. All rights reserved.
//

import UIKit

class InfoTableViewController: UITableViewController {
    var selectedIndexPath : IndexPath?
    
    var faqs = [Faq]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1.0, green: 140.0/255, blue: 140.0/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        loadFaqs()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "AnswerTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AnswerTableViewCell else{
            fatalError("The dequeued cell is not an instance of ProductTableViewCell")
            
        }
        
        
//        cell.questionLabel.text = "When to expire?"
//        cell.answerLabel.text = "Depend on your open date and the production date."
        
        let faq = faqs[indexPath.row]
        
        cell.questionLabel.text = faq.question
        cell.answerLabel.text = faq.answer

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        
        var indexPaths : Array<IndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        if indexPaths.count > 0{
            tableView.reloadRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! AnswerTableViewCell).watchFrameChanges()
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! AnswerTableViewCell).ignoreFrameChanges()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == selectedIndexPath {
            return AnswerTableViewCell.expandedHeight
        }else{
            return AnswerTableViewCell.defaultHeight
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for cell in tableView.visibleCells as! [AnswerTableViewCell] {
            cell.ignoreFrameChanges()
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    private func loadFaqs() {
        guard let faq1 = Faq(question: "When does my cosmetic expire?", answer: "A shelf life cosmetics depends on a period after opening and production data.") else {
            fatalError("Unable to instantiate faq1")
        }
        
        guard let faq2 = Faq(question: "What is period after opening?", answer: "Some cosmetics should be used within a specified period of time after opening due to oxidation and microbiological factors. Their packaging has a drawing of an open jar, inside it, there is a number representing the number of months.") else {
            fatalError("Unable to instantiate faq1")
        }
        
        guard let faq3 = Faq(question: "What is production data?", answer: "Unused cosmetics also lose their freshness and become dry. Some manufacturer has to put the expiration date only on cosmetics whose shelf life is less then 30 months.") else {
            fatalError("Unable to instantiate faq1")
        }
        
        guard let faq4 = Faq(question: "Any common periods of suitablity?", answer: "Perfumes can usually last about 5 years. Skin care can store at least 3 years. For makeup, it is usually between 3 years and 5 years.") else {
            fatalError("Unable to instantiate faq1")
        }
        
        guard let faq5 = Faq(question: "What is Kosmos?", answer: "Kosmos is a cosmetics tracking system that organize and analyze users' cosmetic products by alerting expiration date and personal allergic ingredients in order to help our users to find and use safer products.") else {
            fatalError("Unable to instantiate faq1")
        }

        guard let faq6 = Faq(question: "Who created Kosmos?", answer: "Kosmos is created by a group of informatics students at University of Washington in 2017. They are: Huijie, Tianai, Tim and Yutong.") else {
            fatalError("Unable to instantiate faq1")
        }
        
        faqs += [faq1, faq2, faq3, faq4, faq5, faq6]
        
        
    }
    
    

}
