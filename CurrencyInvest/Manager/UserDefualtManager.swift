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
    
    //======
    //====== currencyTwo =========
    //======
    
    var masterQuotes:[String:Double] {
        
        get {
            
            if let data = userDefault.object(forKey: "masterQuotes") {
                return data as! [String : Double]
            }
            
            return [String:Double]()
        }
        
        set {
            userDefault.set(newValue, forKey: "masterQuotes")
            userDefault.synchronize()
        }
        
    }
    
    
    var masterName:[String] {
        get {
            if let data = userDefault.object(forKey: "masterName") {
                return data as! [String]
            }
            return [String]()
        }

        set {
            userDefault.set(newValue, forKey: "masterName")
            userDefault.synchronize()
            print("Userdefault: localNameArray saved")
        }
    }
    
    var selectedQuotes:[Double] {
        get{
            if let data = userDefault.object(forKey: "selectedQuotes") {
                return data as! [Double]
            }
            return [Double]()
        }
        set{
            userDefault.set(newValue, forKey: "selectedQuotes")
            userDefault.synchronize()
            print("Userdefault: selectedQuotes saved")
        }
    }
    var selectedNames:[String] {
        
        get{
            if let data = userDefault.object(forKey: "selectedNames") {
                return data as! [String]
            }
            return [""]
        }
        set{
            userDefault.set(newValue, forKey: "selectedNames")
            userDefault.synchronize()
            print("Userdefault: selectedNames saved")
        }
    }
    
    
    var selectedAmount:[Double] {
        
        get{
            if let data = userDefault.object(forKey: "selectedAmount") {
                return data as! [Double]
            }
            return [Double]()
        }
        set{
            userDefault.set(newValue, forKey: "selectedAmount")
            userDefault.synchronize()
            print("Userdefault: selectedAmount saved")
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
    
    var localLTCPrice:Double {
        get {
            if let data = userDefault.object(forKey: "ltcPrice") {
                return data as! Double
            }
            return Double()
        }
        set {
            userDefault.set(newValue, forKey: "ltcPrice")
            userDefault.synchronize()
            
        }
        
    }
    
    var localXMRPrice:Double {
        get {
            if let data = userDefault.object(forKey: "xmrPrice") {
                return data as! Double
            }
            return Double()
        }
        set {
            userDefault.set(newValue, forKey: "xmrPrice")
            userDefault.synchronize()
            
        }
        
    }
    
    var localXRPPrice:Double {
        get {
            if let data = userDefault.object(forKey: "xrpPrice") {
                return data as! Double
            }
            return Double()
        }
        set {
            userDefault.set(newValue, forKey: "xrpPrice")
            userDefault.synchronize()
            
        }
        
    }
    
    var localZECPrice:Double {
        get {
            if let data = userDefault.object(forKey: "zecPrice") {
                return data as! Double
            }
            return Double()
        }
        set {
            userDefault.set(newValue, forKey: "zecPrice")
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
    
    
}

