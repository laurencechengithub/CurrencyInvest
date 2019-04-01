//
//  CurrencyViewController.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/1/1.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import UIKit
import NotificationCenter

class CurrencyViewController: UIViewController, NumberPadDelegate, UIScrollViewDelegate {
    

    var scrollView = UIScrollView()
    var backView = UIView()
    var currencyPicker:UIPickerView!
    var currencyOneView:UIView!
    var currencyTwoView:UIView!
    var currencyThreeView:UIView!
    
    var blackView = UIView()
    var numberPadView:NumberPad!
    
    var labelOne = UILabel()
    var nameOne = UILabel()
    var imageViewOne = UIImageView()
    var currencyOneKey = [String]()
    var currencyOneQuotes = [String:Double]()
    
    var labelTwo = UILabel()
    var nameTwo = UILabel()
    var imageViewTwo = UIImageView()
    var currencyTwoQuotes = [String:Double]()
    var currencyTwoKey = [String]()
    
    var labelThree = UILabel()
    var nameThree = UILabel()
    var imageViewThree = UIImageView()
    var currencyThreeQuotes = [String:Double]()
    var currencyThreeKey = [String]()

    

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
                    
                    if let text = labelThree.text {
                        labelThree.text = text + enteredString
                    } else {
                        labelThree.text = enteredString
                    }

                }
            }

        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        Global.isCurrencyPageShowing = true
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
        currencyThreeKey = currencyViewModel.getQuotesKey()
        currencyThreeQuotes = currencyViewModel.getQuotes()
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
        
        let viewWidth = view.frame.width
        backView.frame = CGRect(x: 0, y: 120, width: viewWidth, height: 128)
        backView.backgroundColor = UIColor.green
        view.addSubview(backView)
        view.addSubview(scrollView)
        
        scrollView.addSubview(currencyOneView)
        scrollView.addSubview(currencyTwoView)
        scrollView.addSubview(currencyThreeView)
        scrollView.addSubview(currencyPicker)
        scrollView.addSubview(numberPadView)
        
        currencyOneView.addSubview(nameOne)
        currencyOneView.addSubview(labelOne)
        currencyOneView.addSubview(imageViewOne)
        
        currencyTwoView.addSubview(nameTwo)
        currencyTwoView.addSubview(labelTwo)
        currencyTwoView.addSubview(imageViewTwo)
        
        currencyThreeView.addSubview(labelThree)
        currencyThreeView.addSubview(nameThree)
        currencyThreeView.addSubview(imageViewThree)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.backgroundColor = UIColor.clear
        print(backView.frame.maxY)
        scrollView.contentInset = UIEdgeInsets(top: 128, left: 0, bottom: 0, right: 0)
        scrollView.setContentOffset(CGPoint(x: 0, y: -128), animated: false)
        scrollView.delegate = self
        
        currencyOneView.translatesAutoresizingMaskIntoConstraints = false
        currencyOneView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 44).isActive = true
        currencyOneView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        currencyOneView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30).isActive = true
        currencyOneView.heightAnchor.constraint(equalToConstant: 118).isActive = true
        currencyOneView.backgroundColor = UIColor.ciDeepKoamaru
        currencyOneView.layer.shadowColor = UIColor.ciMaize.cgColor
        currencyOneView.layer.shadowOpacity = 0.5
        currencyOneView.layer.shadowRadius = 5
        currencyOneView.layer.shadowOffset = CGSize(width: 10.0, height: 0.0)
        
        currencyTwoView.translatesAutoresizingMaskIntoConstraints = false
        currencyTwoView.topAnchor.constraint(equalTo: currencyOneView.bottomAnchor, constant: 20).isActive = true
        currencyTwoView.leadingAnchor.constraint(equalTo: currencyOneView.leadingAnchor).isActive = true
        currencyTwoView.trailingAnchor.constraint(equalTo: currencyOneView.trailingAnchor).isActive = true
        currencyTwoView.heightAnchor.constraint(equalToConstant: 118).isActive = true
        currencyTwoView.backgroundColor = UIColor.ciDeepKoamaru
        currencyTwoView.layer.shadowColor = UIColor.white.cgColor
        currencyTwoView.layer.shadowOpacity = 0.5
        currencyTwoView.layer.shadowRadius = 5
        currencyTwoView.layer.shadowOffset = CGSize(width: 10.0, height: 0.0)
        
        currencyThreeView.translatesAutoresizingMaskIntoConstraints = false
        currencyThreeView.topAnchor.constraint(equalTo: currencyTwoView.bottomAnchor, constant: 20).isActive = true
        currencyThreeView.leadingAnchor.constraint(equalTo: currencyTwoView.leadingAnchor).isActive = true
        currencyThreeView.trailingAnchor.constraint(equalTo: currencyTwoView.trailingAnchor).isActive = true
        currencyThreeView.heightAnchor.constraint(equalToConstant: 118).isActive = true
        currencyThreeView.backgroundColor = UIColor.ciDeepKoamaru
        currencyThreeView.layer.shadowColor = UIColor.lightGray.cgColor
        currencyThreeView.layer.shadowOpacity = 0.5
        currencyThreeView.layer.shadowRadius = 5
        currencyThreeView.layer.shadowOffset = CGSize(width: 10.0, height: 0.0)
        
        nameOne.translatesAutoresizingMaskIntoConstraints = false
        nameOne.topAnchor.constraint(equalTo: currencyOneView.topAnchor, constant: 20).isActive = true
        nameOne.leadingAnchor.constraint(equalTo: currencyOneView.leadingAnchor, constant: 90 ).isActive = true
        nameOne.heightAnchor.constraint(equalToConstant: 34).isActive = true
        nameOne.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        nameOne.backgroundColor = UIColor.ciDarkGunMetal
        nameOne.text = Global.NameOne
        nameOne.textColor = UIColor.ciIsabelline
        nameOne.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        nameOne.font = UIFont.boldSystemFont(ofSize: 30)
        
        labelOne.translatesAutoresizingMaskIntoConstraints = false
        labelOne.topAnchor.constraint(equalTo: nameOne.bottomAnchor, constant: 1).isActive = true
        labelOne.leadingAnchor.constraint(equalTo: currencyOneView.leadingAnchor, constant: 90).isActive = true
        labelOne.heightAnchor.constraint(equalToConstant: 44).isActive = true
        labelOne.trailingAnchor.constraint(equalTo: currencyOneView.trailingAnchor, constant: -10).isActive = true
        labelOne.backgroundColor = UIColor.clear
        labelOne.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showNumberPad))
        labelOne.addGestureRecognizer(tapGesture)
        labelOne.textColor = UIColor.ciMaize
        labelOne.font = UIFont.boldSystemFont(ofSize: 30)
        labelOne.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        labelOne.text = String(Global.AmountOne)
        labelOne.textAlignment = .left
        
        imageViewOne.translatesAutoresizingMaskIntoConstraints = false
        imageViewOne.topAnchor.constraint(equalTo: currencyOneView.topAnchor, constant: 30).isActive = true
        imageViewOne.leadingAnchor.constraint(equalTo: currencyOneView.leadingAnchor, constant: 30).isActive = true
        imageViewOne.heightAnchor.constraint(equalToConstant: 58).isActive = true
        imageViewOne.widthAnchor.constraint(equalToConstant: 58).isActive = true
        imageViewOne.backgroundColor = UIColor.blue
        imageViewOne.layer.cornerRadius = 29
        
        imageViewTwo.translatesAutoresizingMaskIntoConstraints = false
        imageViewTwo.topAnchor.constraint(equalTo: currencyTwoView.topAnchor, constant: 30).isActive = true
        imageViewTwo.leadingAnchor.constraint(equalTo: currencyTwoView.leadingAnchor, constant: 30).isActive = true
        imageViewTwo.heightAnchor.constraint(equalToConstant: 58).isActive = true
        imageViewTwo.widthAnchor.constraint(equalToConstant: 58).isActive = true
        imageViewTwo.backgroundColor = UIColor.blue
        imageViewTwo.layer.cornerRadius = 29
        
        imageViewThree.translatesAutoresizingMaskIntoConstraints = false
        imageViewThree.topAnchor.constraint(equalTo: currencyThreeView.topAnchor, constant: 30).isActive = true
        imageViewThree.leadingAnchor.constraint(equalTo: currencyThreeView.leadingAnchor, constant: 30).isActive = true
        imageViewThree.heightAnchor.constraint(equalToConstant: 58).isActive = true
        imageViewThree.widthAnchor.constraint(equalToConstant: 58).isActive = true
        imageViewThree.backgroundColor = UIColor.blue
        imageViewThree.layer.cornerRadius = 29
        
        nameTwo.translatesAutoresizingMaskIntoConstraints = false
        nameTwo.topAnchor.constraint(equalTo: currencyTwoView.topAnchor, constant: 10).isActive = true
        nameTwo.leadingAnchor.constraint(equalTo: currencyTwoView.leadingAnchor, constant: 90).isActive = true
        nameTwo.heightAnchor.constraint(equalToConstant: 34).isActive = true
        nameTwo.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        nameTwo.backgroundColor = UIColor.ciDarkGunMetal
        nameTwo.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        nameTwo.text = Global.NameTwo
        nameTwo.textColor = UIColor.ciIsabelline
        nameTwo.font = UIFont.boldSystemFont(ofSize: 30)
        
        labelTwo.translatesAutoresizingMaskIntoConstraints = false
        labelTwo.topAnchor.constraint(equalTo: nameTwo.bottomAnchor, constant: 1).isActive = true
        labelTwo.leadingAnchor.constraint(equalTo: currencyTwoView.leadingAnchor, constant: 90).isActive = true
        labelTwo.heightAnchor.constraint(equalToConstant: 44).isActive = true
        labelTwo.trailingAnchor.constraint(equalTo: currencyTwoView.trailingAnchor, constant: -10).isActive = true
        labelTwo.backgroundColor = UIColor.clear
        labelTwo.isUserInteractionEnabled = true
        let tapGestureTwo = UITapGestureRecognizer(target: self, action: #selector(showNumberPad))
        labelTwo.addGestureRecognizer(tapGestureTwo)
        labelTwo.textColor = UIColor.ciMaize
        labelTwo.font = UIFont.boldSystemFont(ofSize: 30)
        labelTwo.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        labelTwo.text = String(Global.AmountTwo)
        labelTwo.textAlignment = .left
        
        
        nameThree.translatesAutoresizingMaskIntoConstraints = false
        nameThree.topAnchor.constraint(equalTo: currencyThreeView.topAnchor, constant: 10).isActive = true
        nameThree.leadingAnchor.constraint(equalTo: currencyThreeView.leadingAnchor, constant: 90).isActive = true
        nameThree.heightAnchor.constraint(equalToConstant: 34).isActive = true
        nameThree.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        nameThree.backgroundColor = UIColor.ciDarkGunMetal
        nameThree.text = Global.NameThree
        nameThree.textColor = UIColor.ciIsabelline
        nameThree.font = UIFont.boldSystemFont(ofSize: 30)
        nameThree.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        labelThree.translatesAutoresizingMaskIntoConstraints = false
        labelThree.topAnchor.constraint(equalTo: nameThree.bottomAnchor, constant: 5).isActive = true
        labelThree.leadingAnchor.constraint(equalTo: currencyThreeView.leadingAnchor, constant: 90).isActive = true
        labelThree.heightAnchor.constraint(equalToConstant: 44).isActive = true
        labelThree.trailingAnchor.constraint(equalTo: currencyThreeView.trailingAnchor, constant: -10).isActive = true
        labelThree.backgroundColor = UIColor.clear
        labelThree.isUserInteractionEnabled = true
        let tapGestureThree = UITapGestureRecognizer(target: self, action: #selector(showNumberPad))
        labelThree.addGestureRecognizer(tapGestureThree)
        labelThree.textColor = UIColor.ciMaize
        labelThree.font = UIFont.boldSystemFont(ofSize: 30)
        labelThree.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        labelThree.text = String(Global.AmountThree)
        labelThree.textAlignment = .left
        
        
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
        } else if recongizer.view == labelThree {
            focusedLabel = .LabelThreeInFocus
            labelThree.text = ""
        }

        UIView.animate(withDuration: 0.8) {
            
            self.numberPadView.frame.origin.y = self.numberPadView.frame.origin.y - self.numberPadHeight
        }
        
    }
    
    
    func resetGlobalAmountToZero () {
        
        print("resetGlobalAmountToZero ()")
        Global.AmountOne = 0.0
        Global.AmountTwo = 0.0
        Global.AmountThree = 0.0
        
    }
    
    
    func updateAllLabel () {
        print(Global.AmountOne)
        print(Global.AmountTwo)
        print(Global.AmountThree)
        print("updateAllLabel ()")
        
        if Global.AmountOne == 0 {
            labelOne.text = "0"
        } else {
            let roundnum1 = Global.AmountOne.roundToDecimal(2)
            labelOne.text = "\(roundnum1)"
        }
        if Global.AmountTwo == 0 {
            labelTwo.text = "0"
        }else {
            let roundnum2 = Global.AmountTwo.roundToDecimal(2)
            labelTwo.text = "\(roundnum2)"
        }
        if Global.AmountThree == 0 {
            labelThree.text = "0"
        }else {
            let roundnum3 = Global.AmountThree.roundToDecimal(2)
            labelThree.text = "\(roundnum3)"
        }
        
    }
    

//MARK: NumberPadDelegate
    func getNumberWith(numString: String, numInt: Int) {
        enteredString = numString
    }
    
    func okBtnTapped(bool: Bool) {
        
        isTyping = false
        
        if bool == true {
            UIView.animate(withDuration: 0.8, animations: {
                self.numberPadView.frame.origin.y = self.numberPadView.frame.origin.y + self.numberPadHeight
            })
        }
        
        if let focusLabel = focusedLabel {
            
            switch focusLabel {
            case .LabelOneInFocus:
                if let text = labelOne.text {
                    if let double = Double(text) {
                        
                        Global.AmountOne = double
                        
                        print("Global.RateOne \(Global.RateOne)")
                        print("Global.RateTwo \(Global.RateTwo)")
                        print("Global.RateThree \(Global.RateThree)")
                        
                        Global.AmountTwo = currencyViewModel.calculateWith(inAmount: Global.AmountOne, inRate: Global.RateOne, outRate: Global.RateTwo)
                        Global.AmountThree = currencyViewModel.calculateWith(inAmount: Global.AmountOne, inRate: Global.RateOne, outRate: Global.RateThree)
    
                        updateAllLabel()
                        
                    }

                }else  {
                    
                    resetGlobalAmountToZero ()
                    updateAllLabel ()
                }
                
            case .LabelTwoInFocus:
                
                if let text = labelTwo.text {
                    if let double = Double(text) {
                        Global.AmountTwo = double
                        print("Global.RateOne \(Global.RateOne)")
                        print("Global.RateTwo \(Global.RateTwo)")
                        print("Global.RateThree \(Global.RateThree)")
                        
                        Global.AmountOne = currencyViewModel.calculateWith(inAmount: Global.AmountTwo, inRate: Global.RateTwo, outRate: Global.RateOne)
                        Global.AmountThree = currencyViewModel.calculateWith(inAmount: Global.AmountTwo, inRate: Global.RateTwo, outRate: Global.RateThree)

                        updateAllLabel ()
                        
                    }

                }
                else  {
                    resetGlobalAmountToZero ()
                    updateAllLabel()
                }
                
            case .LabelThreeInFocus:
                
                if let text = labelThree.text {
                    if let double = Double(text) {
                        Global.AmountThree = double
                        print("Global.RateOne \(Global.RateOne)")
                        print("Global.RateTwo \(Global.RateTwo)")
                        print("Global.RateThree \(Global.RateThree)")
                        
                        Global.AmountOne = currencyViewModel.calculateWith(inAmount: Global.AmountThree, inRate: Global.RateThree, outRate: Global.RateOne)
                        Global.AmountTwo = currencyViewModel.calculateWith(inAmount: Global.AmountThree, inRate: Global.RateThree, outRate: Global.RateTwo)
                        updateAllLabel ()
                        
                    }
                    

                }else  {
                    resetGlobalAmountToZero ()
                    updateAllLabel()
                }
            }
        }
        
        
    }
    
    func kBtnTapped(numString : String) {
        enteredString = numString
    }
    
    func tenkBtnTapped(numString: String) {
        enteredString = numString
    }
    
    func hundredBtnTapped(numString: String) {
        enteredString = numString
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
            
        case 2:
            
            guard currencyThreeKey.count > 0 else {
                let alert = UIAlertController(title: "CurrencyInvest", message: "DataBase Empty, Click OK to load from Internet", preferredStyle: .alert)
                
                let actionOne = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                    self.dismiss(animated: true, completion: nil)
                }
                alert.addAction(actionOne)
                self.present(alert, animated: true, completion: nil)
                return nil
            }
            let titleData = currencyThreeKey[row]
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
            //更新匯率名字
            Global.NameOne = currencyOneKey[row]
            nameOne.text = Global.NameOne
            
            //更新匯率
            Global.RateOne = currencyOneQuotes["\(countryString)"] ?? 1.0
            
            Global.AmountTwo = currencyViewModel.calculateWith(inAmount: Global.AmountOne, inRate: Global.RateOne, outRate: Global.RateTwo)
            Global.AmountThree = currencyViewModel.calculateWith(inAmount: Global.AmountOne, inRate: Global.RateOne, outRate: Global.RateThree)
            
            updateAllLabel()
            //設定國旗圖案
            if let image:UIImage = UIImage(named: "\(Global.NameOne)") {
                imageViewOne.image = image
            } else {
                imageViewOne.image = UIImage(named: "logo")
            }
            
        case 1:
            let countryString = "USD\( currencyTwoKey[row])"
            
            //更新匯率名字
            Global.NameTwo = currencyTwoKey[row]
            nameTwo.text = Global.NameTwo
            
            //更新匯率
            Global.RateTwo = currencyTwoQuotes["\(countryString)"] ?? 1.0
            Global.AmountOne = currencyViewModel.calculateWith(inAmount: Global.AmountTwo, inRate: Global.RateTwo, outRate: Global.RateOne)
            Global.AmountThree = currencyViewModel.calculateWith(inAmount: Global.AmountTwo, inRate: Global.RateTwo, outRate: Global.RateThree)
            
            updateAllLabel ()
            //設定國旗圖案
            
            if let image:UIImage = UIImage(named: "\(Global.NameTwo)") {
                imageViewTwo.image = image
            } else {
                imageViewTwo.image = UIImage(named: "logo")
            }
            
        case 2:
            let countryString = "USD\( currencyThreeKey[row])"
            //更新匯率名字
            Global.NameThree = currencyThreeKey[row]
            nameThree.text = Global.NameThree
            
            //更新匯率
            Global.RateThree = currencyThreeQuotes["\(countryString)"] ?? 1.0
            Global.AmountOne = currencyViewModel.calculateWith(inAmount: Global.AmountThree, inRate: Global.RateThree, outRate: Global.RateOne)
            Global.AmountTwo = currencyViewModel.calculateWith(inAmount: Global.AmountThree, inRate: Global.RateThree, outRate: Global.RateTwo)
            updateAllLabel ()
            //設定國旗圖案
            if let image:UIImage = UIImage(named: "\(Global.NameThree)") {
                imageViewThree.image = image
            } else {
                imageViewThree.image = UIImage(named: "logo")
            }
            
        default:
            return
        }
        

        
        
        
        
    }
}


// MARK: DataSource - UIPickerView
extension CurrencyViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0:
            return currencyOneKey.count
        case 1:
            return currencyTwoKey.count
        case 2:
            return currencyThreeKey.count
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
