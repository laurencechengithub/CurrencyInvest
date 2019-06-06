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
            dPrint("Userdefault: masterName saved")
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
            dPrint("Userdefault: selectedQuotes saved")
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
            dPrint("Userdefault: selectedNames saved")
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
            dPrint("Userdefault: selectedAmount saved")
        }
    }
    
    var localBitPrice:Double {
        
        get {
            if let data = userDefault.object(forKey: "localBitPrice") {
                return data as! Double
            }
            return Double()
        }
        
        set {
            userDefault.set(newValue, forKey: "localBitPrice")
            userDefault.synchronize()
            dPrint("Userdefault: localBitPrice saved")
        }
        
    }
    
    var localEthPrice:Double {
        get {
            if let data = userDefault.object(forKey: "localEthPrice") {
                return data as! Double
            }
            return Double()
        }
        
        set {
            userDefault.set(newValue, forKey: "localEthPrice")
            userDefault.synchronize()
            dPrint("Userdefault: localEthPrice saved")
        }
        
    }
    
    var localLTCPrice:Double {
        get {
            if let data = userDefault.object(forKey: "localLTCPrice") {
                return data as! Double
            }
            return Double()
        }
        set {
            userDefault.set(newValue, forKey: "localLTCPrice")
            userDefault.synchronize()
            dPrint("Userdefault: localLTCPrice saved")
        }
        
    }
    
    var localXMRPrice:Double {
        get {
            if let data = userDefault.object(forKey: "localXMRPrice") {
                return data as! Double
            }
            return Double()
        }
        set {
            userDefault.set(newValue, forKey: "localXMRPrice")
            userDefault.synchronize()
            dPrint("Userdefault: localXMRPrice saved")
        }
        
    }
    
    var localXRPPrice:Double {
        get {
            if let data = userDefault.object(forKey: "localXRPPrice") {
                return data as! Double
            }
            return Double()
        }
        set {
            userDefault.set(newValue, forKey: "localXRPPrice")
            userDefault.synchronize()
            dPrint("Userdefault: localXRPPrice saved")
        }
        
    }
    
    var localZECPrice:Double {
        get {
            if let data = userDefault.object(forKey: "localZECPrice") {
                return data as! Double
            }
            return Double()
        }
        set {
            userDefault.set(newValue, forKey: "localZECPrice")
            userDefault.synchronize()
            dPrint("Userdefault: localZECPrice saved")
            
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
            dPrint("Userdefault: localCryptoPriceArray saved")
            
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
            dPrint("Userdefault: localCryptoTypeArray saved")
            
        }
        
    }
    
    var isBought:Bool {
        get{
            if let data = userDefault.object(forKey: "isBought") {
                return data as! Bool
            }
            return false
        }
        
        set {
            userDefault.set(newValue, forKey: "isBought")
            userDefault.synchronize()
            dPrint("Userdefault: isBought saved")
        }
        
    }
    
    var isFirstTimeEnterApp:Bool {
        get{
            if let data = userDefault.object(forKey: "isFirstTimeEnterApp") {
                return data as! Bool
            }
            return true
        }
        
        set {
            userDefault.set(newValue, forKey: "isFirstTimeEnterApp")
            userDefault.synchronize()
            dPrint("Userdefault: isFirstTimeEnterApp saved")
        }
    }
    
    var lastIndexPathRow:Int {
        get{
            if let data = userDefault.object(forKey: "lastIndexPathRow") {
                return data as! Int
            }
            return 0
        }
        
        set {
            userDefault.set(newValue, forKey: "lastIndexPathRow")
            userDefault.synchronize()
            dPrint("Userdefault: lastIndexPathRow saved")
        }
    }
    
    
    var lastEnterAmount:Double {
        get{
            if let data = userDefault.object(forKey: "lastEnterAmount") {
                return data as! Double
            }
            return 0
        }
        
        set {
            userDefault.set(newValue, forKey: "lastEnterAmount")
            userDefault.synchronize()
            dPrint("Userdefault: lastEnterAmount saved")
        }
    }
    
    
}

