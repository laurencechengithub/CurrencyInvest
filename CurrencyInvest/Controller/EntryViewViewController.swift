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
    
//    let mainViewModel = MainViewModel()
    let entryViewViewModel = EntryViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        getData()
 
    }
    
    func initView() {
        //        SwiftSpinner.show("Loading")
    }
    
    func getData () {

            self.toMainView ()
        
//        entryViewViewModel.getQuotes()
//        entryViewViewModel.quotesCompleteHandler = { (flag) in
//
//            if flag == true {
//                DispatchQueue.main.async {
//                    self.toMainView ()
//                }
//            } else {
//                print("get quote not completede")
//            }
//
//        }
        
    }
    
    func toMainView () {
        let vc = MainViewController()
        self.present(vc, animated: true, completion: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    


}
