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
            return 0
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
            return 0
        }
        
        set {
            userDefault.set(newValue, forKey: "amountTwo")
            userDefault.synchronize()
        }
    }
    

    var localNameThree:String {
        get {
            if let data = userDefault.object(forKey: "nameThree") {
                return data as! String
            }
            return String()
        }
        
        set {
            userDefault.set(newValue, forKey: "nameThree")
            userDefault.synchronize()
        }
    }
    
    
    
    var localRateThree:Double {
        get {
            if let data = userDefault.object(forKey: "rateThree") {
                return data as! Double
            }
            return Double()
        }
        
        set {
            userDefault.set(newValue, forKey: "rateThree")
            userDefault.synchronize()
        }
    }
    
    
    
    var localAmountThree:Double {
        get {
            if let data = userDefault.object(forKey: "amountThree") {
                return data as! Double
            }
            return 0
        }
        
        set {
            userDefault.set(newValue, forKey: "amountThree")
            userDefault.synchronize()
        }
    }
    
    
    
    var localBitPrice:Double {
        
        get {
            if let data = userDefault.object(forKey: "bitPrice") {
                return data as! Double
            }
            return Double()
        }
        
        set {
            userDefault.set(newValue, forKey: "bitPrice")
            userDefault.synchronize()
            
        }
        
    }
    
    var localEthPrice:Double {
        
        get {
            if let data = userDefault.object(forKey: "ethPrice") {
                return data as! Double
            }
            return Double()
        }
        
        set {
            userDefault.set(newValue, forKey: "ethPrice")
            userDefault.synchronize()
            
        }
        
    }
    
    var localCryptoPriceArray:[Double] {
        
        get {
            if let data = userDefault.object(forKey: "localCryptoPriceArray") {
                return data as! [Double]
            }
            return [Double]()
        }
        
        set {
            userDefault.set(newValue, forKey: "localCryptoPriceArray")
            userDefault.synchronize()
            
        }
        
        
    }
    
    var localCryptoTypeArray:[String] {
        
        get {
            if let data = userDefault.object(forKey: "localCryptoTypeArray") {
                return data as! [String]
            }
            return [String]()
        }
        
        set {
            userDefault.set(newValue, forKey: "localCryptoTypeArray")
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

