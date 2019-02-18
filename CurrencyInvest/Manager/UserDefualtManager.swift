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
    
    var localNameOne:String {
        get {
            if let data = userDefault.object(forKey: "nameOne") {
                return data as! String
            }
            return String()
        }
        
        set {
            userDefault.set(newValue, forKey: "nameOne")
            userDefault.synchronize()
        }
    }
    
    
    var localRateOne:Double {
        get {
            if let data = userDefault.object(forKey: "rateOne") {
                return data as! Double
            }
            return Double()
        }
        
        set {
            userDefault.set(newValue, forKey: "rateOne")
            userDefault.synchronize()
        }
    }
    
    
    var localAmountOne:Double {
        get {
            if let data = userDefault.object(forKey: "amountOne") {
                return data as! Double
            }
            return Double()
        }
        
        set {
            userDefault.set(newValue, forKey: "amountOne")
            userDefault.synchronize()
        }
    }
    
    
    var localNameTwo:String {
        get {
            if let data = userDefault.object(forKey: "nameTwo") {
                return data as! String
            }
            return String()
        }
        
        set {
            userDefault.set(newValue, forKey: "nameTwo")
            userDefault.synchronize()
        }
    }
    
    
    
    var localRateTwo:Double {
        get {
            if let data = userDefault.object(forKey: "rateTwo") {
                return data as! Double
            }
            return Double()
        }
        
        set {
            userDefault.set(newValue, forKey: "rateTwo")
            userDefault.synchronize()
        }
    }
    

    
    var localAmountTwo:Double {
        get {
            if let data = userDefault.object(forKey: "amountTwo") {
                return data as! Double
            }
            return Double()
        }
        
        set {
            userDefault.set(newValue, forKey: "amountTwo")
            userDefault.synchronize()
        }
    }
    
    
//    var dataSetOne:[Any] {
//        get {
//            if let data = userDefault.object(forKey: "SetOne") {
//                return data as! [Any]
//            }
//            return [Any]()
//        }
//
//        set {
//
//        }
//    }
    
    
    
}

