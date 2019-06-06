//
//  NavigationManager.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/5/7.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation
import UIKit

class NavigationManager {
    
    static var sharedInstance = NavigationManager()
    private let appdelegate = AppDelegate()
    
    private init() {}
    
    
    
    func toEntryView() {
        
        let entrySB = UIStoryboard.init(name: "EntryView", bundle: nil)
        let vc = entrySB.instantiateViewController(withIdentifier: "EntryViewViewController") as! EntryViewViewController
    }
    
    func toRootView() {

        if let root = appdelegate.window?.rootViewController {
            root.loadView()
        }
    }
    
//    func toCurrencyView(<#parameters#>) -> <#return type#> {
//
//
//
//    }
//
//    func toBitCoinView(<#parameters#>) -> <#return type#> {
//        <#function body#>
//    }
    
    
}
