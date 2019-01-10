//
//  UserDefualtManager.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2018/12/25.
//  Copyright © 2018 Laurence  Chen. All rights reserved.
//

import Foundation

class UserDefualtManager {
    static let sharedInstance = UserDefualtManager()
    
    private init() {}
    
    private var userDefault = UserDefaults.standard
    
    var localQuote:[String:Double] {
        
        get {
            
            if let data = userDefault.object(forKey: "historyQuotes") {
                return data as! [String : Double]
            }
            
            return [String:Double]()
        }
        
        set {
            userDefault.set(newValue, forKey: "historyQuotes")
            userDefault.synchronize()
        }
        
    }
    
}

