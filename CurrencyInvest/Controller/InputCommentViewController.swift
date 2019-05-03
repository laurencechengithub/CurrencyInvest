//
//  InputCommentViewController.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/4/30.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import UIKit

class InputCommentViewController: UIViewController {

    var inputViewWithLabel: UIViewWithTextFieldAndOnTopLabels!
    var name:String = ""
    var rate:Double = 0
    var amount:Double = 0
    var comment:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(dissmissCurrent))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapgesture)
        
        let viewWidth = self.view.frame.width
        inputViewWithLabel = UIViewWithTextFieldAndOnTopLabels(frame: CGRect(x: 25, y: view.frame.maxY/3, width: viewWidth - 50, height: 212), name: self.name, rate: self.rate, amount: self.amount)
        inputViewWithLabel.okBtnTappedWithComment = { (bool,comment) in
            if bool == true {
                self.comment = comment
                
                CoreDataManager.sharedInstance.saveToExchangeList(name: self.name,
                                                                  rate: self.rate,
                                                                  amount: self.amount.roundToDecimal(2),
                                                                  comment: self.comment)
                self.toListView()
            } else {
                self.comment = "empty"
            }
        }
        self.view.addSubview(inputViewWithLabel)
        
        
        
    }
    
    @objc func dissmissCurrent() {
        self.dismiss(animated: true) {
        }
    }
    
    func toListView() {

        self.dismiss(animated: true) {
            
            let mainSB = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainSB.instantiateViewController(withIdentifier: "SavedRateListViewController") as! SavedRateListViewController

            self.present(vc, animated: true, completion: nil)
        }
        
    }
    

}
