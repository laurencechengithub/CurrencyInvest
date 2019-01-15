//
//  MainViewController.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/1/1.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var topView:UIView!
    var btmView:UIView!
    var currencyPicker:UIPickerView!
    

    var labelOne = UILabel()
    var labelTwo = UILabel()
    
    var mainViewModel = MainViewModel()
    
    var currentOne = [String:Double]()
    var currenttwo = [String:Double]()
    var currentthree = [String:Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
        
    }
    
    func initView () {
        
        topView = UIView()
        btmView = UIView()
        currencyPicker = UIPickerView()
        view.addSubview(topView)
        view.addSubview(btmView)
        
        topView.addSubview(labelOne)
        topView.addSubview(labelTwo)
        
        btmView.addSubview(currencyPicker)
        
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        topView.backgroundColor = UIColor.blue
        
        labelOne.translatesAutoresizingMaskIntoConstraints = false
        labelOne.topAnchor.constraint(equalTo: topView.topAnchor, constant: 30).isActive = true
        labelOne.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 10).isActive = true
        labelOne.heightAnchor.constraint(equalToConstant: 44).isActive = true
        labelOne.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10).isActive = true
        labelOne.backgroundColor = UIColor.lightGray
        
        labelTwo.translatesAutoresizingMaskIntoConstraints = false
        labelTwo.topAnchor.constraint(equalTo: labelOne.bottomAnchor, constant: 10).isActive = true
        labelTwo.leadingAnchor.constraint(equalTo: labelOne.leadingAnchor).isActive = true
        labelTwo.heightAnchor.constraint(equalToConstant: 44).isActive = true
        labelTwo.trailingAnchor.constraint(equalTo: labelOne.trailingAnchor).isActive = true
        labelTwo.backgroundColor = UIColor.lightGray
        
        
        btmView.translatesAutoresizingMaskIntoConstraints = false
        btmView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        btmView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        btmView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        btmView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        btmView.backgroundColor = UIColor.darkGray
        
        currencyPicker.translatesAutoresizingMaskIntoConstraints = false
        currencyPicker.topAnchor.constraint(equalTo: btmView.topAnchor).isActive = true
        currencyPicker.trailingAnchor.constraint(equalTo: btmView.trailingAnchor).isActive = true
        currencyPicker.leadingAnchor.constraint(equalTo: btmView.leadingAnchor).isActive = true
        currencyPicker.bottomAnchor.constraint(equalTo: btmView.bottomAnchor).isActive = true
        //        currencyPicker.backgroundColor = UIColor.darkGray
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
        
    }

    
}

extension MainViewController: UIPickerViewDelegate {
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let countryString = "USD\( mainViewModel.currencyKeys[row])"
        labelOne.text = countryString
        print(countryString)
        
        if let selectedQuote = mainViewModel.currencyQuotes["\(countryString)"] {
            print(selectedQuote)
            
        }
        
        
        
        
    }
}



extension MainViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mainViewModel.currencyKeys.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return mainViewModel.currencyKeys[row]
    }
    
    
    
    
}
