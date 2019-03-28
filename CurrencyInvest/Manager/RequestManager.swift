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
        case cryptoLTC = "https://apiv2.bitcoinaverage.com/indices/global/ticker/LTCUSD"
        case cryptoXMR = "https://apiv2.bitcoinaverage.com/indices/global/ticker/XMRUSD"
        case cryptoXRP = "https://apiv2.bitcoinaverage.com/indices/global/ticker/XRPUSD"
        case cryptoZEC = "https://apiv2.bitcoinaverage.com/indices/global/ticker/ZECUSD"
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

    @discardableResult private func baseRequest (url:String,
                      isSwiftSpinner:Bool,
                      method: HTTPMethod,
                      parameters: Parameters? = nil,
                      encoding: ParameterEncoding = URLEncoding.default,
                      headers: HTTPHeaders? = nil,
                      completionHandler:@escaping (_ responseJSON: JSON?) -> ()) -> DataRequest {
        
        return Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON(completionHandler: { (responseData) in
            switch responseData.result {
            case .success(let value):
                let jsonData = JSON(value)
                completionHandler(jsonData)
            case .failure(let error):
                print(error)
                completionHandler(nil)
            }
        })
    }
    
    
    
    
    
    func getBitCoinData (completeHandler:@escaping (CryptoDataModel?)->()) {
        
        baseRequest(url: Url.cryptoBTC.rawValue, isSwiftSpinner: true, method: .get) { (JsonData) in
            
            guard let json = JsonData else {
                completeHandler(nil)
                return
            }
            completeHandler(CryptoDataModel(fromJson: json))
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
    
    func getLTCCoinData (completeHandler:@escaping (CryptoDataModel)->()) {
        
        Alamofire.request(Url.cryptoLTC.rawValue, method: .get).responseJSON { (data) in
            switch data.result {
            case .success(let value):
                let jsonData = JSON(value)
                completeHandler(CryptoDataModel(fromJson: jsonData))
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getXMRCoinData (completeHandler:@escaping (CryptoDataModel)->()) {
        
        Alamofire.request(Url.cryptoXMR.rawValue, method: .get).responseJSON { (data) in
            switch data.result {
            case .success(let value):
                let jsonData = JSON(value)
                completeHandler(CryptoDataModel(fromJson: jsonData))
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getXRPCoinData (completeHandler:@escaping (CryptoDataModel)->()) {
        
        Alamofire.request(Url.cryptoXRP.rawValue, method: .get).responseJSON { (data) in
            switch data.result {
            case .success(let value):
                let jsonData = JSON(value)
                completeHandler(CryptoDataModel(fromJson: jsonData))
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getZECCoinData (completeHandler:@escaping (CryptoDataModel)->()) {
        
        Alamofire.request(Url.cryptoZEC.rawValue, method: .get).responseJSON { (data) in
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
