//
//  RequestManager.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2018/12/17.
//  Copyright © 2018 Laurence  Chen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RequestManager {
    
    static let sharedInstance = RequestManager()
    
    enum Url:String {
        
        case currency = "http://apilayer.net/api/live?access_key=0c056c4320688c8c947e54ab6f59bfcb"
        case crypto = ""
    }
    
//    var currencyDataModel:CurrencyDataModel?

    private init() {}
    
    func getCurrecyRate(completiondHandler: @escaping (_ Rate: CurrencyDataModel) -> ()) {
       
        guard let url = URL(string: Url.currency.rawValue) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let theData = data else {
                print("data is nil")
                return
            }
            
            do {
                let modelData = try JSONDecoder().decode(CurrencyDataModel.self,from:theData)
                print(modelData)
                
                completiondHandler(modelData)
                
            } catch {
                
                let showError = error
                print(showError)
                
            }
        
        }.resume()
        
    }

    func baseRequest (url:URL,isSwiftSpinner:Bool,completiondHandler:@escaping (_ Rate: CurrencyDataModel) -> ()) {
        
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let theData = data else {
                print("data is nil")
                return
            }
            
            do {
                let modelData = try JSONDecoder().decode(CurrencyDataModel.self,from:theData)
                print(modelData)
                
                completiondHandler(modelData)
                
            } catch {
                
                let showError = error
                print(showError)
                
            }
            
            }.resume()
        
    }
    
    
    
    
    
}
