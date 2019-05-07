//
//  NoticeViewController.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/5/3.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation
import UIKit
import StoreKit


class NoticeViewController: UIViewController {

    var centerBoard:UIView = UIView()
    var cancelBtn = UIButton()
    var buyBtn = UIButton()
    var productID = "com.llng_intl.MoneyXBit.buyMeCoffee"
    var descriptionLabel = UILabel()
    var isBought = Bool()
    
    override func viewDidLoad() {
        setView()
        SKPaymentQueue.default().add(self)
    }
    
    
    func setView() {
        
        self.view.addSubview(centerBoard)
        centerBoard.addSubview(descriptionLabel)
        centerBoard.addSubview(cancelBtn)
        centerBoard.addSubview(buyBtn)
        
        centerBoard.translatesAutoresizingMaskIntoConstraints = false
        centerBoard.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        centerBoard.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        centerBoard.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.5).isActive = true
        centerBoard.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.8).isActive = true
        centerBoard.backgroundColor = UIColor.ciDownArrowBlue
        centerBoard.layer.cornerRadius = 10
        
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        cancelBtn.topAnchor.constraint(equalTo: centerBoard.topAnchor, constant: 5).isActive = true
//        cancelBtn.leadingAnchor.constraint(equalTo: centerBoard.leadingAnchor, constant: 10).isActive = true
        cancelBtn.trailingAnchor.constraint(equalTo: centerBoard.trailingAnchor, constant: -10).isActive = true
        cancelBtn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        cancelBtn.widthAnchor.constraint(equalToConstant: 20).isActive = true
        cancelBtn.setTitle("⊗", for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnTapped), for: .touchUpInside)
        
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: cancelBtn.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: centerBoard.leadingAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: centerBoard.trailingAnchor, constant: -10).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: centerBoard.bottomAnchor, constant: -64).isActive = true
        descriptionLabel.text = "Hi Guys! I hope you liked this app, I'm an individual developer, who desires to make human living more convenience. If you find this app useful pls award me a cup of coffee so I can keep coding and won't doze off to sleep..."
        descriptionLabel.backgroundColor = UIColor.clear
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        descriptionLabel.numberOfLines = 0
        
        
        buyBtn.translatesAutoresizingMaskIntoConstraints = false
        buyBtn.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        buyBtn.leadingAnchor.constraint(equalTo: centerBoard.leadingAnchor, constant: 40).isActive = true
        buyBtn.trailingAnchor.constraint(equalTo: centerBoard.trailingAnchor, constant: -40).isActive = true
        buyBtn.bottomAnchor.constraint(equalTo: centerBoard.bottomAnchor, constant: -10).isActive = true
        
        if Global.isCoffeeBought == false {
            buyBtn.setTitle("Sure, Buy you Coffee", for: .normal)
        } else {
            buyBtn.setTitle("Thanks for the Coffee", for: .normal)
            buyBtn.isUserInteractionEnabled = false
        }
        
        buyBtn.addTarget(self, action: #selector(buyBtnTapped), for: .touchUpInside)
        buyBtn.layer.borderWidth = 2
        buyBtn.layer.borderColor = UIColor.white.cgColor
        buyBtn.layer.cornerRadius = 10
    }
    
    
    
    @objc func buyBtnTapped() {
        
        if SKPaymentQueue.canMakePayments() == true {
            
            //can make payment
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
            
        } else {
            
            //can't make payment
            dPrint("SKPaymentQueue.canMakePayments() return false")
        }
        
    }
    
    
    @objc func cancelBtnTapped() {
        if let navi = navigationController {
            navi.popViewController(animated: true)
        }
        
    }
    
}

//In app purchase
extension NoticeViewController: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            if transaction.transactionState == .purchased {

                // give something inreturn to user
                UserDefualtManager.sharedInstance.isBought = true
                
                SKPaymentQueue.default().finishTransaction(transaction)
                // reload app
                if let navi = navigationController {
                    navi.popToRootViewController(animated: true)
                }
                
            } else if transaction.transactionState == .failed {
                
                if let error = transaction.error {
                    let errordescription = error.localizedDescription
                    dPrint("paymentQueue transactionState == .failed : \(errordescription)")
                }
                
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
        
    }
    
    

    
}
