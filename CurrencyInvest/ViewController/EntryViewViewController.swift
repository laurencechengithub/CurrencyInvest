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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getQuote()
        // Do any additional setup after loading the view.
    }
    
    func initView() {
        
    }
    
    func getQuote () {
        let mainViewModel = MainViewModel()
//        SwiftSpinner.show("Loading")
        mainViewModel.quotesLoadCompleteHandler = { (flag) in
            if flag == true {
                self.toMainView ()
//                SwiftSpinner.hide({
//                    self.toMainView ()
//                })

            }else {
                
            }
            
        }
        
    }
    
    func toMainView () {
        let vc = MainViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
