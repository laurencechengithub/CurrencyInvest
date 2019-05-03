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
    
    override func viewDidLoad() {
        setView()
        SKPaymentQueue.default().add(self)
    }
    
    
    func setView() {
        
        self.view.addSubview(centerBoard)
        
        centerBoard.translatesAutoresizingMaskIntoConstraints = false
        centerBoard.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        centerBoard.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        centerBoard.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.7).isActive = true
        centerBoard.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.7).isActive = true
        centerBoard.backgroundColor = UIColor.ciDownArrowBlue
        centerBoard.layer.cornerRadius = 10
        
        
        
    }
    
    
    
    func buyBtnTapped() {
        
        if SKPaymentQueue.canMakePayments() == true {
            
            //can make payment
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
            
        } else {
            
            //can't make payment
            print("SKPaymentQueue.canMakePayments() return false")
        }
        
    }
    
    

    
}


extension NoticeViewController: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            if transaction.transactionState == .purchased {
                
                SKPaymentQueue.default().finishTransaction(transaction)
                
                
                
            } else if transaction.transactionState == .failed {
                
                if let error = transaction.error {
                    let errordescription = error.localizedDescription
                    print(errordescription)
                }
                
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
        
    }
    
    
    func isBuyCoffeeChecked() {
        
        
        
        
    }
    
}
