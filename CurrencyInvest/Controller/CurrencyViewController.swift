//
//  CurrencyViewController.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/1/1.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import UIKit
import NotificationCenter

class CurrencyViewController: UIViewController, NumberPadDelegate {
    
    var currencyPicker:UIPickerView!
    var currencyOneView:UIView!
    var currencyTwoView:UIView!
    var currencyThreeView:UIView!
    var numberPadView:NumberPad!
    
    var labelOne = UILabel()
    var labelTwo = UILabel()
    var labelThree = UILabel()
    var nameOne = UILabel()
    var nameTwo = UILabel()
    var currencyOneKey = [String]()
    var currencyOneQuotes = [String:Double]()
    var currencyTwoQuotes = [String:Double]()
    var currencyTwoKey = [String]()
//    var currencyThreeQuotes = [String:Double]()
//    var currencyThreeKey = [String]()
    let currencyViewModel = CurrencyViewModel()
    var numberPadViewTopAnchor:NSLayoutConstraint!
//    var currentthree = [String:Double]()
    var focusedLabel:LabelType?
    var numberPadHeight:CGFloat!
    var isTyping:Bool = false
    
    enum LabelType: Int {
        
        case LabelOneInFocus
        case LabelTwoInFocus
        case LabelThreeInFocus
    }
    
    var enteredString:String = "" {
        
        didSet{
            print("didset")
            
            
            
            if let focusedLabel = focusedLabel {
                switch focusedLabel {
                case .LabelOneInFocus :
                    if let text = labelOne.text {
                        labelOne.text = text + enteredString
                    } else {
                        labelOne.text = enteredString
                    }
                    
                case .LabelTwoInFocus :
                    
                    if let text = labelTwo.text {
                        labelTwo.text = text + enteredString
                    } else {
                        labelTwo.text = enteredString
                    }
         
                case .LabelThreeInFocus :
                    print("three")

                }
            }

        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initView()
        updateAllLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {

        
    }
    
    func initData () {
        
        currencyOneKey = currencyViewModel.getQuotesKey()
        currencyOneQuotes = currencyViewModel.getQuotes()
        currencyTwoKey = currencyViewModel.getQuotesKey()
        currencyTwoQuotes = currencyViewModel.getQuotes()
    }
    
    func initView () {
        
        view.backgroundColor = UIColor.ciDarkGunMetal
        currencyPicker = UIPickerView()
        currencyOneView = UIView()
        currencyTwoView = UIView()
        currencyThreeView = UIView()
        numberPadHeight = self.view.frame.height * 0.4
        numberPadView = NumberPad(frame: CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.width, height: numberPadHeight))
        numberPadView.numberPadDelegate = self
        
        print(self.view.frame.width)
        print(self.view.frame.height)
        //...
//        view.addSubview(mainContainerView)
        view.addSubview(currencyOneView)
        view.addSubview(currencyTwoView)
        view.addSubview(currencyThreeView)
        view.addSubview(currencyPicker)
        view.addSubview(numberPadView)
        
        currencyOneView.addSubview(nameOne)
        currencyOneView.addSubview(labelOne)
        currencyTwoView.addSubview(nameTwo)
        currencyTwoView.addSubview(labelTwo)
        currencyThreeView.addSubview(labelThree)
        
        
        
        currencyOneView.translatesAutoresizingMaskIntoConstraints = false
        currencyOneView.topAnchor.constraint(equalTo: view.topAnchor, constant: 174).isActive = true
        currencyOneView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        currencyOneView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        currencyOneView.heightAnchor.constraint(equalToConstant: 118).isActive = true
        currencyOneView.backgroundColor = UIColor.ciDeepKoamaru
        
        currencyTwoView.translatesAutoresizingMaskIntoConstraints = false
        currencyTwoView.topAnchor.constraint(equalTo: currencyOneView.bottomAnchor, constant: 10).isActive = true
        currencyTwoView.leadingAnchor.constraint(equalTo: currencyOneView.leadingAnchor).isActive = true
        currencyTwoView.trailingAnchor.constraint(equalTo: currencyOneView.trailingAnchor).isActive = true
        currencyTwoView.heightAnchor.constraint(equalToConstant: 118).isActive = true
        currencyTwoView.backgroundColor = UIColor.ciDeepKoamaru
        
        currencyThreeView.translatesAutoresizingMaskIntoConstraints = false
        currencyThreeView.topAnchor.constraint(equalTo: currencyTwoView.bottomAnchor, constant: 10).isActive = true
        currencyThreeView.leadingAnchor.constraint(equalTo: currencyTwoView.leadingAnchor).isActive = true
        currencyThreeView.trailingAnchor.constraint(equalTo: currencyTwoView.trailingAnchor).isActive = true
        currencyThreeView.heightAnchor.constraint(equalToConstant: 118).isActive = true
        currencyThreeView.backgroundColor = UIColor.ciDeepKoamaru
        
        
        nameOne.translatesAutoresizingMaskIntoConstraints = false
        nameOne.topAnchor.constraint(equalTo: currencyOneView.topAnchor, constant: 10).isActive = true
        nameOne.leadingAnchor.constraint(equalTo: currencyOneView.leadingAnchor, constant: 10).isActive = true
        nameOne.heightAnchor.constraint(equalToConstant: 44).isActive = true
        nameOne.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameOne.backgroundColor = UIColor.ciDarkGunMetal
//        nameOne.layer.borderWidth = 1
//        nameOne.layer.borderColor = UIColor.white.cgColor
//        nameOne.layer.cornerRadius = 20
        nameOne.text = Global.NameOne
        nameOne.textColor = UIColor.ciIsabelline
        nameOne.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        nameOne.font = UIFont.boldSystemFont(ofSize: 30)
        
        labelOne.translatesAutoresizingMaskIntoConstraints = false
        labelOne.topAnchor.constraint(equalTo: nameOne.bottomAnchor, constant: 10).isActive = true
        labelOne.leadingAnchor.constraint(equalTo: currencyOneView.leadingAnchor, constant: 10).isActive = true
        labelOne.heightAnchor.constraint(equalToConstant: 44).isActive = true
        labelOne.trailingAnchor.constraint(equalTo: currencyOneView.trailingAnchor, constant: -10).isActive = true
        labelOne.backgroundColor = UIColor.clear
//        labelOne.layer.borderWidth = 3
//        labelOne.layer.borderColor = UIColor.white.cgColor
//        labelOne.layer.cornerRadius = 20
        labelOne.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showNumberPad))
        labelOne.addGestureRecognizer(tapGesture)
        labelOne.textColor = UIColor.ciMaize
        labelOne.font = UIFont.boldSystemFont(ofSize: 30)
        labelOne.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        labelOne.text = String(Global.AmountOne)
        
        
        nameTwo.translatesAutoresizingMaskIntoConstraints = false
        nameTwo.topAnchor.constraint(equalTo: currencyTwoView.topAnchor, constant: 10).isActive = true
        nameTwo.leadingAnchor.constraint(equalTo: currencyTwoView.leadingAnchor, constant: 10).isActive = true
        nameTwo.heightAnchor.constraint(equalToConstant: 44).isActive = true
        nameTwo.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameTwo.backgroundColor = UIColor.ciDarkGunMetal
//        nameTwo.layer.borderWidth = 1
//        nameTwo.layer.borderColor = UIColor.white.cgColor
//        nameTwo.layer.cornerRadius = 20
        nameTwo.text = Global.NameTwo
        nameTwo.textColor = UIColor.ciIsabelline
        nameTwo.font = UIFont.boldSystemFont(ofSize: 30)
        
        labelTwo.translatesAutoresizingMaskIntoConstraints = false
        labelTwo.topAnchor.constraint(equalTo: nameTwo.bottomAnchor, constant: 10).isActive = true
        labelTwo.leadingAnchor.constraint(equalTo: currencyTwoView.leadingAnchor, constant: 10).isActive = true
        labelTwo.heightAnchor.constraint(equalToConstant: 44).isActive = true
        labelTwo.trailingAnchor.constraint(equalTo: currencyTwoView.trailingAnchor, constant: -10).isActive = true
        labelTwo.backgroundColor = UIColor.clear
//        labelTwo.layer.borderWidth = 3
//        labelTwo.layer.borderColor = UIColor.white.cgColor
//        labelTwo.layer.cornerRadius = 20
        labelTwo.isUserInteractionEnabled = true
        let tapGestureTwo = UITapGestureRecognizer(target: self, action: #selector(showNumberPad))
        labelTwo.addGestureRecognizer(tapGestureTwo)
        labelTwo.textColor = UIColor.ciMaize
        labelTwo.font = UIFont.boldSystemFont(ofSize: 30)
        labelTwo.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        labelTwo.text = String(Global.AmountTwo)
        
        labelThree.translatesAutoresizingMaskIntoConstraints = false
        labelThree.topAnchor.constraint(equalTo: currencyThreeView.topAnchor, constant: 10).isActive = true
        labelThree.leadingAnchor.constraint(equalTo: currencyThreeView.leadingAnchor, constant: 10).isActive = true
        labelThree.heightAnchor.constraint(equalToConstant: 44).isActive = true
        labelThree.trailingAnchor.constraint(equalTo: currencyThreeView.trailingAnchor, constant: -10).isActive = true
        labelThree.backgroundColor = UIColor.clear
        labelThree.layer.borderWidth = 3
        labelThree.layer.borderColor = UIColor.white.cgColor
        labelThree.layer.cornerRadius = 20
        
        
        currencyPicker.translatesAutoresizingMaskIntoConstraints = false
        currencyPicker.topAnchor.constraint(equalTo: currencyThreeView.bottomAnchor, constant: 10).isActive = true
        currencyPicker.trailingAnchor.constraint(equalTo: currencyThreeView.trailingAnchor).isActive = true
        currencyPicker.leadingAnchor.constraint(equalTo: currencyThreeView.leadingAnchor).isActive = true
        currencyPicker.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        currencyPicker.backgroundColor = UIColor.ciDarkGunMetal
        currencyPicker.delegate = self
        currencyPicker.dataSource = self

        
//        numberPadView.translatesAutoresizingMaskIntoConstraints = false
//        let getViewHeight:CGFloat = self.view.frame.height
//        numberPadViewTopAnchor = numberPadView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: getViewHeight)
//        numberPadViewTopAnchor.isActive = true
//        numberPadView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//        numberPadView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//        numberPadView.heightAnchor.constraint(equalToConstant: 250).isActive = true
 
    }
    
//MARK: Self Designed Function
    @objc func showNumberPad (_ recongizer:UIGestureRecognizer) {
    
        guard isTyping == false else {
            return
        }
        print("func showNumberPad typing")
        isTyping = true
        
        if recongizer.view == labelOne {
            focusedLabel = .LabelOneInFocus
            labelOne.text = ""
        } else if recongizer.view == labelTwo {
            focusedLabel = .LabelTwoInFocus
            labelTwo.text = ""
        } else {
            print("else")
        }
        print(numberPadView.frame.origin.y)
            
        
        UIView.animate(withDuration: 1.2) {
            self.numberPadView.frame.origin.y = self.numberPadView.frame.origin.y - self.numberPadHeight
        }
        
    }
    
    

//MARK: NumberPadDelegate
    func getNumberWith(numString: String, numInt: Int) {
        print("get string \(numString)")
        enteredString = numString
        print(enteredString)
    }
    
    func okBtnTapped(bool: Bool) {
        
        isTyping = false
        
        if bool == true {
            UIView.animate(withDuration: 1.2, animations: {
                self.numberPadView.frame.origin.y = self.numberPadView.frame.origin.y + self.numberPadHeight
            })
        }
        
        if let focusLabel = focusedLabel {
            
            switch focusLabel {
            case .LabelOneInFocus:
                if let text = labelOne.text {
                    if let double = Double(text) {
                        Global.AmountOne = double
                        Global.AmountTwo = currencyViewModel.calculateWith(inAmount: Global.AmountOne, inRate: Global.RateOne, outRate: Global.RateTwo)
                        Global.AmountThree = currencyViewModel.calculateWith(inAmount: Global.AmountOne, inRate: Global.RateOne, outRate: Global.RateThree)
                        updateAllLabel()
                    } else if labelOne.text == "" {
                        resetGlobalAmountToZero ()
                        updateAllLabel ()
                    }

                }else  {
                    
                    resetGlobalAmountToZero ()
                    updateAllLabel ()
                }
                
            case .LabelTwoInFocus:
                
                if let text = labelTwo.text {
                    if let double = Double(text) {
                        Global.AmountTwo = double
                        Global.AmountOne = currencyViewModel.calculateWith(inAmount: Global.AmountTwo, inRate: Global.RateTwo, outRate: Global.RateOne)
                        Global.AmountThree = currencyViewModel.calculateWith(inAmount: Global.AmountTwo, inRate: Global.RateTwo, outRate: Global.RateThree)
                        updateAllLabel ()
                        
                    } else if labelTwo.text == "" {

                        resetGlobalAmountToZero ()
                        updateAllLabel ()
                    }


                }else  {
                    resetGlobalAmountToZero ()
                    updateAllLabel()
                }
                
            case .LabelThreeInFocus:
                print("three")
            }
        }
        
        
    }
    
    func resetGlobalAmountToZero () {
        
        print("resetGlobalAmountToZero ()")
        Global.AmountOne = 0.0
        Global.AmountTwo = 0.0
        Global.AmountThree = 0.0
        
    }
    
    
    func updateAllLabel () {
        
        print("updateAllLabel ()")
        if Global.AmountOne == 0.0 {
            labelOne.text = "0"
        }
        if Global.AmountTwo == 0.0 {
            labelTwo.text = "0"
        }
        if Global.AmountThree == 0.0 {
            labelThree.text = "0"
        }
        
    }
    
    
    
}

// MARK: Deledate - UIPickerView
extension CurrencyViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        //變換 picker View title color
        switch component {
        case 0:
            guard currencyOneKey.count > 0 else {
                
                let alert = UIAlertController(title: "CurrencyInvest", message: "Fail to Load Data,please check your Internet connection and re", preferredStyle: .alert)
                
                let actionOne = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                    self.dismiss(animated: true, completion: {
                    })
                }
                alert.addAction(actionOne)
                self.present(alert, animated: true, completion: nil)
                return nil
            }
            
            let titleData = currencyOneKey[row]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
            return myTitle
        case 1:
            
            guard currencyTwoKey.count > 0 else {
                let alert = UIAlertController(title: "CurrencyInvest", message: "DataBase Empty, Click OK to load from Internet", preferredStyle: .alert)
                
                let actionOne = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                    self.dismiss(animated: true, completion: nil)
                }
                alert.addAction(actionOne)
                self.present(alert, animated: true, completion: nil)
                return nil
            }
            let titleData = currencyTwoKey[row]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
            return myTitle
            
        default:
            return nil
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch component {
        case 0:
            let countryString = "USD\( currencyOneKey[row])"
            Global.NameOne = currencyOneKey[row]
            Global.RateOne = currencyOneQuotes["\(countryString)"] ?? 1.0
            nameOne.text = Global.NameOne
            // TBD 設定國旗圖案
        case 1:
            let countryString = "USD\( currencyTwoKey[row])"
 
            Global.NameTwo = currencyTwoKey[row]
            Global.RateTwo = currencyTwoQuotes["\(countryString)"] ?? 1.0
            nameTwo.text = Global.NameTwo
            // TBD 設定國旗圖案
        default:
            return
        }
        

        
        
        
        
    }
}


// MARK: DataSource - UIPickerView
extension CurrencyViewController: UIPickerViewDataSource {
    
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
    
    
// 因為有 attributedTitleForRow 所以下面可以省略
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//
//        switch component {
//        case 0:
//            return currencyOneKey[row]
//        case 1:
//            return currencyTwoKey[row]
//        default:
//            return "nil"
//        }
//
//    }
    
    
}


//extension MainViewController: UITextFieldDelegate {
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        print("textFieldDidBeginEditing")
//        labelTwo.text = "textFieldDidBeginEditing"
//    }
//
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//
//        print("textFieldDidEndEditing")
//
//        if textField == textFieldOne {
//            mainViewModel.calculateUSD(textField: textFieldOne, inRate: Global.CurrencyOneRate)
//            textFieldTwo.text = String (Global.amountUSD * Global.CurrencyTwoRate)
//        }else if textField == textFieldTwo {
//            mainViewModel.calculateUSD(textField: textFieldTwo, inRate: Global.CurrencyTwoRate)
//            textFieldOne.text = String (Global.amountUSD * Global.CurrencyOneRate)
//        }
//
//    }
//
//
//
//}
