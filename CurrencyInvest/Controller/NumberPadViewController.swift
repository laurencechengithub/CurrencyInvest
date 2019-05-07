//
//  NumberPadViewController.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/4/12.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import UIKit

protocol NumberPadViewControllerDelegate:class {
    func getUserEnterNumber(bool:Bool,num:Double)
}


class NumberPadViewController: UIViewController {
    
    var returnFinalCalculateNumber:((Bool,Double)->())!
    var numberScrollView = UIScrollView()
    var numberLabel = UILabel()
    var numberLabelWidthConstrant = NSLayoutConstraint()
    var calculateResultLabel = UILabel()
    var padView: NumberPad!
    var enterString:String = "" {
        
        didSet {
            if let text = numberLabel.text {
                let newtext = text + enterString
                
                let width = numberLabel.WidthForLabelWith(text: newtext, font: UIFont.boldSystemFont(ofSize: 24), height: 84)
                
                numberLabelWidthConstrant.constant = 60 + width
                numberLabel.text = newtext
                
                if numberScrollView.contentSize.width > numberScrollView.bounds.size.width {
                    
                    let scrollRightEndContentOffset = CGPoint(x: numberScrollView.contentSize.width - numberScrollView.bounds.size.width, y: 0)
                    numberScrollView.setContentOffset(scrollRightEndContentOffset, animated: true)
                } else {
                    
                    
                }

            }
        }
        
    }
    weak var delegate:NumberPadViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        let numberPadHeight:CGFloat = self.view.frame.height * 0.4
        padView = NumberPad(frame: CGRect(x: 0, y: (self.view.frame.maxY * 0.6), width: self.view.frame.width, height: numberPadHeight))
        
        self.view.addSubview(calculateResultLabel)
        self.view.addSubview(padView)
        self.view.addSubview(numberScrollView)
        self.numberScrollView.addSubview(numberLabel)
        
        padView.numberPadDelegate = self
        
        let numberScrollViewWidth = self.view.frame.width * 0.8
        
        calculateResultLabel.translatesAutoresizingMaskIntoConstraints = false
        calculateResultLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        calculateResultLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height/3).isActive = true
        calculateResultLabel.widthAnchor.constraint(equalToConstant: numberScrollViewWidth).isActive = true
        calculateResultLabel.heightAnchor.constraint(equalToConstant: 64).isActive = true
        calculateResultLabel.padding = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        calculateResultLabel.backgroundColor = UIColor.ciButtonGreen.withAlphaComponent(0.9)
        calculateResultLabel.textColor = UIColor.white
        calculateResultLabel.font = UIFont.boldSystemFont(ofSize: 28)
        calculateResultLabel.layer.cornerRadius = 20
        calculateResultLabel.layer.masksToBounds = true
        calculateResultLabel.textAlignment = .left
        calculateResultLabel.text = ""
        
        
        
        numberScrollView.translatesAutoresizingMaskIntoConstraints = false
        numberScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        numberScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -numberPadHeight+20).isActive = true
        numberScrollView.widthAnchor.constraint(equalToConstant: numberScrollViewWidth).isActive = true
        numberScrollView.heightAnchor.constraint(equalToConstant: 84).isActive = true
        numberScrollView.backgroundColor = UIColor.ciJet.withAlphaComponent(1)
        numberScrollView.showsHorizontalScrollIndicator = true
        numberScrollView.layer.cornerRadius = 20
        numberScrollView.layer.masksToBounds = true
//        numberScrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: numberLabel.trailingAnchor).isActive = true
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.leadingAnchor.constraint(equalTo: self.numberScrollView.leadingAnchor, constant: 0).isActive = true
        numberLabel.trailingAnchor.constraint(equalTo: self.numberScrollView.trailingAnchor, constant: 0).isActive = true
        numberLabelWidthConstrant = numberLabel.widthAnchor.constraint(equalToConstant: 60)//any number just to start
        numberLabelWidthConstrant.isActive = true
        numberLabel.topAnchor.constraint(equalTo: self.numberScrollView.topAnchor).isActive = true
        numberLabel.heightAnchor.constraint(equalTo: self.numberScrollView.heightAnchor).isActive = true
        numberLabel.backgroundColor = UIColor.clear
        numberLabel.layer.cornerRadius = 20
        numberLabel.layer.masksToBounds = true
        numberLabel.text = ""
        numberLabel.textColor = UIColor.darkGray
        numberLabel.font = UIFont.boldSystemFont(ofSize: 24)
        numberLabel.padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
    
    }
    
    

}

extension NumberPadViewController: NumberPadDelegate {


    func numberTapped(numString: String, numInt: Int) {
        enterString = numString
    }
    
    func okBtnTapped(bool: Bool) {
        
        guard numberLabel.text != "" else {
            self.dismiss(animated: true) {
                self.returnFinalCalculateNumber(false,0)
            }
            return
        }
        
        if let numericString = numberLabel.text {
            //calculate mathmatical logic
            let expression = NSExpression(format: numericString)
            let result = expression.expressionValue(with: nil, context: nil) as! NSNumber
            let doubleNum = Double(truncating: result)
            
            //OK tapped will divert double
            self.dismiss(animated: true) {
                self.returnFinalCalculateNumber(true,doubleNum.roundToDecimal(2))
            }
        } else {
            calculateResultLabel.text = String(0.0)
            self.dismiss(animated: true) {
                self.returnFinalCalculateNumber(false,0)
            }
        }

        
    }
    
    func kBtnTapped(numString: String) {
        enterString = numString
    }

    
    func equalBtnTapped(bool: Bool) {
        if bool == true {
            if let numericString = numberLabel.text {
                //calculate mathmatical logic
                let expression = NSExpression(format: numericString)
                let result = expression.expressionValue(with: nil, context: nil) as! NSNumber
                let doubleNum = Double(truncating: result)
                
                calculateResultLabel.text = String(doubleNum.roundToDecimal(2))
            }
        }
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
    
    func clearBtnTapped(bool: Bool) {
        if bool == true {
            numberLabel.text = ""
        }
    }
    
    
    
    func dotBtnTapped(bool: Bool) {
        if bool == true {
            enterString = "."
        }
    }
    
}
