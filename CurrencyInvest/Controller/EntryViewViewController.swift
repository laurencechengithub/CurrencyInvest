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
        
        getBitCoin()
        
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
                    self.getLTCCoin()
                }
            } else {
                print("get Eth not complete")
            }
            
        }
    }
    
    func getLTCCoin() {
        entryViewViewModel.getLTCPrice()
        entryViewViewModel.ltcCompleteHandler = { (bool) in
            
            if bool == true {
                DispatchQueue.main.async {
                    self.getXMRCoin()
                }
            } else {
                print("get Eth not complete")
            }
            
        }
    }
    
    func getXMRCoin() {
        entryViewViewModel.getXMRPrice()
        entryViewViewModel.xmrCompleteHandler = { (bool) in
            
            if bool == true {
                DispatchQueue.main.async {
                    self.getXRPCoin()
                }
            } else {
                print("get Eth not complete")
            }
            
        }
    }
    
    func getXRPCoin() {
        entryViewViewModel.getXRPPrice()
        entryViewViewModel.xrpCompleteHandler = { (bool) in
            
            if bool == true {
                DispatchQueue.main.async {
                    self.getZECCoin()
                }
            } else {
                print("get Eth not complete")
            }
            
        }
    }
    func getZECCoin() {
        entryViewViewModel.getZECPrice()
        entryViewViewModel.zecCompleteHandler = { (bool) in
            
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
        
        
        
        
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let currencyTwo = mainStoryboard.instantiateViewController(withIdentifier: "CurrencyTwo") as! CurrencyTwo
//        let CurrencyVC = mainStoryboard.instantiateViewController(withIdentifier: "CurrencyViewController") as! CurrencyViewController
//        let vc = mainStoryboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        self.present(currencyTwo, animated: true, completion: nil)
        
    }
    


}
