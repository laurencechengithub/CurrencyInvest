//
//  EntryViewViewController.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/1/4.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import UIKit
import SwiftSpinner

class EntryViewViewController: UIViewController {
    
    let entryViewViewModel = EntryViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrency()
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SwiftSpinner.show(duration: 1.8, title: "Loading")
    }
    
    
    func getCurrency () {
        
        self.getBitCoin()
        
//        entryViewViewModel.getQuotes()
//        entryViewViewModel.quotesCompleteHandler = { (bool) in
//
//            if bool == true {
//                DispatchQueue.main.async {
//                    self.getBitCoin()
//                }
//            } else {
//                print("get quote not complete")
//            }
//        }
        
    }
    
    func getBitCoin() {
        
        entryViewViewModel.getBitPrice()
        entryViewViewModel.bitCompleteHandler = { (bool) in
            
            if bool == true {
                DispatchQueue.main.async {
                self.getEthCoin()
                }
            } else {
                print("get Bit not complete")
            }
            
        }

    }
    
    
    func getEthCoin() {
        entryViewViewModel.getEthPrice()
        entryViewViewModel.ethCompleteHandler = { (bool) in
        
            if bool == true {
                DispatchQueue.main.async {
                    self.toMainView()
                }
            } else {
                print("get Eth not complete")
            }
            
        }
    }
    
    
    func toMainView() {
        
        entryViewViewModel.saveDataToUserDefault()
        print (UserDefualtManager.sharedInstance.localCryptoPriceArray)
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let CurrencyVC = mainStoryboard.instantiateViewController(withIdentifier: "CurrencyViewController") as! CurrencyViewController
//        let vc = mainStoryboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        self.present(CurrencyVC, animated: true, completion: nil)
        
    }
    


}
