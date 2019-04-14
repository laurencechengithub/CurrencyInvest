//
//  NumberPadViewController.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/4/12.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import UIKit

class NumberPadViewController: UIViewController {
    
    var enterNumberCompleteHandler:((Bool,Double)->())!
    var numberLabel = UILabel()
    var padView: NumberPad!
    var enterString:String = "" {
        
        didSet {
            if let text = numberLabel.text {
                numberLabel.text = text + enterString
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        let numberPadHeight:CGFloat = self.view.frame.height * 0.5
        padView = NumberPad(frame: CGRect(x: 0, y: (self.view.frame.maxY/2), width: self.view.frame.width, height: numberPadHeight))
        
        self.view.addSubview(padView)
        self.view.addSubview(numberLabel)
        
        padView.numberPadDelegate = self
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        numberLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
        numberLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -numberPadHeight).isActive = true
        numberLabel.heightAnchor.constraint(equalToConstant: 104).isActive = true
        numberLabel.backgroundColor = UIColor.white
        numberLabel.layer.cornerRadius = 20
        
    }
    
    

}

extension NumberPadViewController: NumberPadDelegate {

    func numberTapped(numString: String, numInt: Int) {
        enterString = numString
    }
    
    func okBtnTapped(bool: Bool) {
        
        if let numericString = numberLabel.text {
            //calculate mathmatical logic
            let expression = NSExpression(format: numericString)
            var result = expression.expressionValue(with: nil, context: nil) as! NSNumber
            let doubleNum = Double(truncating: result)
            
            //OK tapped will divert double
            self.dismiss(animated: true) {
                self.enterNumberCompleteHandler(true,doubleNum)
            }
        } else {
            self.dismiss(animated: true) {
                self.enterNumberCompleteHandler(true,0)
            }
        }

        
    }
    
    func kBtnTapped(numString: String) {
        enterString = numString
    }
    
    func tenkBtnTapped(numString: String) {
        enterString = numString
    }
    
    func hundredBtnTapped(numString: String) {
        enterString = numString
    }
    
    func plusBtnTapped(bool: Bool) {
        if bool == true {
            enterString = "+"
        }
    }
    
    func minusBtnTapped(bool: Bool) {
        if bool == true {
            enterString = "-"
        }
    }
    
    func divideBtnTapped(bool: Bool) {
        if bool == true {
            enterString = "/"
        }
    }
    
    func multiplyBtnTapped(bool: Bool) {
        if bool == true {
            enterString = "*"
        }
    }
    
    func deleteBtnTapped(bool: Bool) {
        if bool == true {
            if let text = numberLabel.text {
                var newtext = ""
                newtext = String(text.dropLast())
                numberLabel.text = newtext
            }
        }
    }
    
    func dotBtnTapped(bool: Bool) {
        if bool == true {
            enterString = "."
        }
    }
    
}
