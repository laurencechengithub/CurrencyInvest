//
//  MainViewController.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/1/1.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import UIKit
import NotificationCenter

class MainViewController: UIViewController {
    
    var scrollView:UIScrollView!
    var topView:UIView!
    var btmView:UIView!
    var currencyPicker:UIPickerView!
    var currencyOneView:UIView!
    var currencyTwoView:UIView!
    
    
    var textFieldOne = UITextField()
    var textFieldTwo = UITextField()
    var currencyOneKey = [String]()
    var currencyOneQuotes = [String:Double]()
    var currencyTwoQuotes = [String:Double]()
    var currencyTwoKey = [String]()
//    var currencyThreeQuotes = [String:Double]()
//    var currencyThreeKey = [String]()
    let mainViewModel = MainViewModel()

//    var currentthree = [String:Double]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func initData () {
        
        currencyOneKey = mainViewModel.getQuotesKey()
        currencyOneQuotes = mainViewModel.getQuotes()
        currencyTwoKey = mainViewModel.getQuotesKey()
        currencyTwoQuotes = mainViewModel.getQuotes()
    }
    
    func initView () {
        
        topView = UIView()
        btmView = UIView()
        currencyPicker = UIPickerView()
        view.addSubview(topView)
        view.addSubview(btmView)
        
        topView.addSubview(textFieldOne)
        topView.addSubview(textFieldTwo)
        
        btmView.addSubview(currencyPicker)
        
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
        topView.backgroundColor = UIColor.blue
        
        textFieldOne.delegate = self
        textFieldOne.translatesAutoresizingMaskIntoConstraints = false
        textFieldOne.topAnchor.constraint(equalTo: topView.topAnchor, constant: 60).isActive = true
        textFieldOne.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 10).isActive = true
        textFieldOne.heightAnchor.constraint(equalToConstant: 44).isActive = true
        textFieldOne.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10).isActive = true
        textFieldOne.backgroundColor = UIColor.lightGray
        textFieldOne.keyboardType = .numberPad
        
        textFieldTwo.delegate = self
        textFieldTwo.translatesAutoresizingMaskIntoConstraints = false
        textFieldTwo.topAnchor.constraint(equalTo: textFieldOne.bottomAnchor, constant: 10).isActive = true
        textFieldTwo.leadingAnchor.constraint(equalTo: textFieldOne.leadingAnchor).isActive = true
        textFieldTwo.heightAnchor.constraint(equalToConstant: 44).isActive = true
        textFieldTwo.trailingAnchor.constraint(equalTo: textFieldOne.trailingAnchor).isActive = true
        textFieldTwo.backgroundColor = UIColor.lightGray
        textFieldTwo.keyboardType = .numberPad
        
        btmView.translatesAutoresizingMaskIntoConstraints = false
        btmView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        btmView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        btmView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        btmView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        btmView.backgroundColor = UIColor.darkGray
        
        currencyPicker.translatesAutoresizingMaskIntoConstraints = false
        currencyPicker.topAnchor.constraint(equalTo: btmView.topAnchor).isActive = true
        currencyPicker.trailingAnchor.constraint(equalTo: btmView.trailingAnchor).isActive = true
        currencyPicker.leadingAnchor.constraint(equalTo: btmView.leadingAnchor).isActive = true
        currencyPicker.bottomAnchor.constraint(equalTo: btmView.bottomAnchor).isActive = true
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
        
    }

    
}

extension MainViewController: UIPickerViewDelegate {
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch component {
        case 0:
            let countryString = "USD\( currencyOneKey[row])"
            Global.CurrencyOneName = countryString
            Global.CurrencyOneRate = currencyOneQuotes["\(countryString)"] ?? 1.0
            textFieldOne.placeholder = Global.CurrencyOneName // need change to label
            // TBD 設定國旗圖案
        case 1:
            let countryString = "USD\( currencyTwoKey[row])"
 
            Global.CurrencyTwoName = countryString
            Global.CurrencyTwoRate = currencyTwoQuotes["\(countryString)"] ?? 1.0
            textFieldTwo.placeholder = Global.CurrencyTwoName // need change to label
            // TBD 設定國旗圖案
        default:
            return
        }
        

        
        
        
        
    }
}



extension MainViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0:
            return currencyOneKey.count
        case 1:
            return currencyTwoKey.count

        default:
            return 0
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        print(currencyTwoKey[row])
        switch component {
        case 0:
            return currencyOneKey[row]
        case 1:
            return currencyTwoKey[row]
        default:
            return "nil"
        }

    }
    
    
}


extension MainViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
        textFieldTwo.text = "textFieldDidBeginEditing"
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    
        print("textFieldDidEndEditing")
        
        if textField == textFieldOne {
            mainViewModel.calculateUSD(textField: textFieldOne, inRate: Global.CurrencyOneRate)
            textFieldTwo.text = String (Global.amountUSD * Global.CurrencyTwoRate)
        }else if textField == textFieldTwo {
            mainViewModel.calculateUSD(textField: textFieldTwo, inRate: Global.CurrencyTwoRate)
            textFieldOne.text = String (Global.amountUSD * Global.CurrencyOneRate)
        }
       
    }
    
    
    
}
