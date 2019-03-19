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
        case cryptoHistryBTC = "https://apiv2.bitcoinaverage.com/indices/global/history/BTCUSD"
        case cryptoBTC = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCUSD"
        case cryptoETH = "https://apiv2.bitcoinaverage.com/indices/global/ticker/ETHUSD"
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
    
    
    func getBitCoinData (completeHandler:@escaping (CryptoDataModel)->()) {
//        let ethUrl = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCUSD"

        Alamofire.request(Url.cryptoBTC.rawValue, method: .get).responseJSON { (data) in
            switch data.result {
            case .success(let value):
                let jsonData = JSON(value)
                completeHandler(CryptoDataModel(fromJson: jsonData))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func getEthCoinData (completeHandler:@escaping (CryptoDataModel)->()) {
//        let ethUrl = "https://apiv2.bitcoinaverage.com/indices/global/ticker/ETHUSD"
        Alamofire.request(Url.cryptoETH.rawValue, method: .get).responseJSON { (data) in
            switch data.result {
            case .success(let value):
                let jsonData = JSON(value)
                completeHandler(CryptoDataModel(fromJson: jsonData))
        
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    
    
}
