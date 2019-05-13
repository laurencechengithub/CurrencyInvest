//
//  CurrencyTwo.swift
//  CurrencyInvest
//
//  Created by Laurence Chen on 2019/3/31.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation
import UIKit


class CurrencyViewController: UIViewController {
    
    let currencyViewModel = CurrencyViewModel()
    let backgdView = UIView()
    let backListImage = UIImageView()
    let backBuyMeCoffee = UIImageView()
    let backRemoveImage = UIImageView()
    
    var collectionView: TapThroughCollectionView!
    let flowLayout = UICollectionViewFlowLayout()
    
    var allQuotesWithName = [String:Double]() {
        didSet {
            Global.allQuotes = self.allQuotesWithName
        }
    }
    
    var allNamesArray = [String]() {
        didSet{
            Global.allNames = self.allNamesArray
        }
    }
    
    var selectedQuotesArray = [Double]() {
        didSet {
            Global.selectedQuotes = self.selectedQuotesArray
        }
    }
    var selectedNamesArray = [""] {
        didSet {
            Global.selectedNames = self.selectedNamesArray
        }
    }
    var selectedAmountArray = [Double]() {
        didSet{
            Global.selectedAmounts = self.selectedAmountArray
//            collectionView.reloadData()
        }
    }
    
    var numberPadHeight:CGFloat!
//    var userEnterAmount = Double()
//    var lastIndexPath = IndexPath()
    lazy var inputText = UITextField()
    
    override func viewDidLoad() {
        setData()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor.ciDarkGunMetal
        self.view.addSubview(backgdView)
        self.backgdView.addSubview(backListImage)
        self.backgdView.addSubview(backBuyMeCoffee)
        self.backgdView.addSubview(backRemoveImage)
        
        backgdView.translatesAutoresizingMaskIntoConstraints = false
        backgdView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        backgdView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 164).isActive = true
        backgdView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        backgdView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        backgdView.backgroundColor = UIColor.clear
        
        let imageWidth = (self.view.frame.width - 270)/3
        backListImage.translatesAutoresizingMaskIntoConstraints = false
        backListImage.leadingAnchor.constraint(equalTo: backgdView.leadingAnchor, constant: 90).isActive = true
        backListImage.topAnchor.constraint(equalTo: backgdView.topAnchor, constant: 60).isActive = true
        backListImage.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
        backListImage.heightAnchor.constraint(equalToConstant: imageWidth).isActive = true
        backListImage.backgroundColor = UIColor.clear
        backListImage.image = UIImage(named: "seeList")
        let tapGestureList = UITapGestureRecognizer(target: self, action: #selector(showSaveList))
        backListImage.addGestureRecognizer(tapGestureList)
        backListImage.isUserInteractionEnabled = true
        
        backBuyMeCoffee.translatesAutoresizingMaskIntoConstraints = false
        backBuyMeCoffee.leadingAnchor.constraint(equalTo: backListImage.trailingAnchor, constant: 45).isActive = true
        backBuyMeCoffee.topAnchor.constraint(equalTo: backListImage.topAnchor).isActive = true
        backBuyMeCoffee.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
        backBuyMeCoffee.heightAnchor.constraint(equalToConstant: imageWidth).isActive = true
        backBuyMeCoffee.backgroundColor = UIColor.clear
        backBuyMeCoffee.image = UIImage(named: "buyMeCoffee")
        let tapGestureCoffee = UITapGestureRecognizer(target: self, action: #selector(askForCoffee))
        backBuyMeCoffee.addGestureRecognizer(tapGestureCoffee)
        backBuyMeCoffee.isUserInteractionEnabled = true
        
        backRemoveImage.translatesAutoresizingMaskIntoConstraints = false
        backRemoveImage.leadingAnchor.constraint(equalTo: backBuyMeCoffee.trailingAnchor, constant: 45).isActive = true
        backRemoveImage.topAnchor.constraint(equalTo: backBuyMeCoffee.topAnchor).isActive = true
        backRemoveImage.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
        backRemoveImage.heightAnchor.constraint(equalToConstant: imageWidth).isActive = true
        backRemoveImage.backgroundColor = UIColor.clear
        backRemoveImage.image = UIImage(named: "removeListItem")
        let tapGestureRemove = UITapGestureRecognizer(target: self, action: #selector(removeAllCell))
        backRemoveImage.addGestureRecognizer(tapGestureRemove)
        backRemoveImage.isUserInteractionEnabled = true
        
       
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: self.view.frame.width * 0.8 , height: 64)
        flowLayout.minimumLineSpacing = CGFloat(integerLiteral: 30)
        flowLayout.minimumInteritemSpacing = CGFloat(integerLiteral: 10)
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical //預設
        flowLayout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 54)
        collectionView = TapThroughCollectionView.init(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.register(CurrencyCollectionViewCell.self, forCellWithReuseIdentifier: "reuseCell")
        collectionView.register(NothingCollectionViewCell.self, forCellWithReuseIdentifier: "nothingCell")
        collectionView.backgroundColor = UIColor.clear
        
        collectionView.register(CurrencyHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.addSubview(collectionView)
        
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 164).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        collectionView.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)//collectionView 底下滑的空間
        collectionView.setContentOffset(CGPoint(x: 0, y: -150), animated: false)// 手機上顯示collectionView顯示的部分
        collectionView.delegate = self
        collectionView.dataSource = self

        
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    
    func setData() {
        allQuotesWithName = currencyViewModel.getQuotes()
        allNamesArray = currencyViewModel.getQuotesKey()
        selectedNamesArray = currencyViewModel.lastSelectedName()
        selectedQuotesArray = currencyViewModel.lastSelectedQuotes()
        selectedAmountArray = currencyViewModel.lastSelectedAmount()
        Global.lastEnterAmount = currencyViewModel.lastEnterAmount()
        Global.lastIndexPathRow = currencyViewModel.lastEnterIndexPathRow()
    }
    
    @objc func askForCoffee() {
        //present new view ask for in-app-purchase or show add
        let noticeViewController = NoticeViewController()
//        self.present(noticeViewController, animated: true) {
//
//        }
        
        self.navigationController?.pushViewController(noticeViewController, animated: true)
        
    }
    
    @objc func showSaveDataInputView(with Name:String, Rate:Double, Amount:Double) {
        //create input text
        let mainStoryB:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = mainStoryB.instantiateViewController(withIdentifier: "InputCommentViewController") as! InputCommentViewController
        
        vc.amount = Amount
        vc.name = Name
        vc.rate = Rate
        vc.modalPresentationStyle = .custom
        self.present(vc, animated: true) {
            
        }
    }
    
    
    @objc func showSaveList() {
        
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainSB.instantiateViewController(withIdentifier: "SavedRateListViewController") as! SavedRateListViewController
        self.present(vc, animated: true)
        
    }
    
    
    @objc func removeLastCell() {
        
        if selectedNamesArray.count > 1 {
            
            let count = selectedNamesArray.count
            let index = selectedNamesArray.index(count, offsetBy: -1)
            _ = selectedQuotesArray.removeLast()
            _ = selectedNamesArray.remove(at: index - 1) //刪除右邊倒數第二個
            _ = selectedAmountArray.removeLast()
            
        }
        
        reloadData()
        
    }
    
    @objc func removeAllCell() {
        selectedQuotesArray.removeAll()
        selectedNamesArray.removeAll()
        selectedNamesArray.append("")
        selectedAmountArray.removeAll()
        
        reloadData()
    }
    
}


extension CurrencyViewController: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedNamesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if selectedNamesArray[indexPath.row] == "" {
            var inRate = 0.0
            let nothingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "nothingCell", for: indexPath) as! NothingCollectionViewCell
            
            nothingCell.plusBtnTapHandler = { (flag) in
                if flag == true {
                    let vc = RateTypePicker()
                    vc.lastSelectedName = ""
                    vc.modalTransitionStyle = .crossDissolve
                    self.present(vc, animated: true, completion: nil)
                    
                    vc.returnSelectName = { (flag,name) in
                        self.selectedNamesArray[indexPath.row] = name
                        //base on name findout the rate and show it at cell
                        inRate = self.allQuotesWithName["USD\(name)"] ?? 0
                        //save to selectedQuotes
                        self.selectedQuotesArray.append(inRate)
//                        self.selectedAmountArray.append(0)
                        
                        //再算一次幣別amount
                        self.selectedAmountArray = self.currencyViewModel.calculateAllAmount(
                            inAmount: Global.lastEnterAmount,
                            selectedNames: Global.selectedNames,
                            selectedQuotes: Global.selectedQuotes,
                            indexPathRow: Global.lastIndexPathRow )
                        
                        if Global.isCoffeeBought == false && self.selectedNamesArray.count < 10 {
                            self.selectedNamesArray.append("")
                            
                        } else if Global.isCoffeeBought == true && self.selectedNamesArray.count < 15 {
                            self.selectedNamesArray.append("")
                            
                        }
                        
                        self.reloadData()
                        
                    }
                }
                
            }
            return nothingCell
        } else {
            var inRate = 0.0
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseCell", for: indexPath) as! CurrencyCollectionViewCell
            
            cell.setImage(string: "\(selectedNamesArray[indexPath.row])")
            cell.rateName.text = selectedNamesArray[indexPath.row]
            cell.rateAmount.text = "\(selectedAmountArray[indexPath.row].roundToDecimal(2))"
            //偵測到user點擊國家幣別
            cell.smallBackViewTapHandler = { (bool) in
                if bool == true {
                    let vc = RateTypePicker()
                    vc.lastSelectedName = self.selectedNamesArray[indexPath.row]
                    
                    vc.modalTransitionStyle = .crossDissolve
                    self.present(vc, animated: true, completion: nil)
                    
                    vc.returnSelectName = { (flag,name) in
                        if flag == true {
                            //show selected rate name amd image
                            cell.rateName.text = name
                            cell.setImage(string: name)
                            //add name into selectedNamesArray
                            self.selectedNamesArray[indexPath.row] = name
                            //base on name findout the rate
                            inRate = self.allQuotesWithName["USD\(name)"] ?? 0
                            //save to selectedQuotes
                            self.selectedQuotesArray[indexPath.row] = inRate
                            
                            //再算一次幣別amount
                            self.selectedAmountArray = self.currencyViewModel.calculateAllAmount(
                                inAmount: Global.lastEnterAmount,
                                selectedNames: Global.selectedNames,
                                selectedQuotes: Global.selectedQuotes,
                                indexPathRow: Global.lastIndexPathRow )
                            
                            self.reloadData()
                            
                        }
                    }
                    

                    
                    
                }
            }
            //偵測到user點擊數量
            cell.rateAmountTapHandler = { (bool) in
                if bool == true {
                    
                    let numberPadVC = NumberPadViewController()
                    numberPadVC.modalPresentationStyle = .custom
                    numberPadVC.modalTransitionStyle = .crossDissolve
                    
                    UIView.animate(withDuration: 0.8) {
                        self.present(numberPadVC, animated: true, completion: { })
                    }
                    
                    numberPadVC.returnFinalCalculateNumber = { (flag,double) in
                        if flag == true {
                            
                            //紀錄最後一次收尋時的內容
                            Global.lastEnterAmount = double
                            Global.lastIndexPathRow = indexPath.row
                            //*
                            self.selectedAmountArray = self.currencyViewModel.calculateAllAmount(
                                inAmount: double,
                                selectedNames: self.selectedNamesArray,
                                selectedQuotes:self.selectedQuotesArray,
                                indexPathRow: indexPath.row )
                            cell.rateAmount.text = "\(self.selectedAmountArray[indexPath.row])"
                            
                        }
                        self.reloadData()
                    }
                }
                
            }
            //偵測到user點擊儲存
            cell.saveToListBtnHandler = { (flag) in
                if flag == true {
                    self.showSaveDataInputView(with: self.selectedNamesArray[indexPath.row],
                                          Rate: self.selectedQuotesArray[indexPath.row],
                                          Amount: self.selectedAmountArray[indexPath.row])
                }
            }
            
            return cell
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as! CurrencyHeaderCollectionReusableView
        view.backgroundColor = UIColor.ciDarkGunMetal
        if self.selectedNamesArray.count > 1 {
            view.deleteBtn.backgroundColor = UIColor.ciButtonGreen
            view.deleteBtn.isUserInteractionEnabled = true
        } else {
            view.deleteBtn.backgroundColor = UIColor.darkGray
            view.deleteBtn.isUserInteractionEnabled = false
        }
        
        view.btnTappedHandler = { (bool) in
            if bool == true {
                
                if self.selectedNamesArray.count > 1 {
                    self.removeLastCell()
                }
                
            }
        }
        return view
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func reloadData() {
        
        dPrint("CurrencyView reloadData")
        dPrint("selectedQuotesArray: \(selectedQuotesArray)")
        dPrint("selectedNamesArray: \(selectedNamesArray)")
        dPrint("selectedAmountArray: \(selectedAmountArray)")
        
        collectionView.reloadData()
        
    }
    
    
}



extension CurrencyViewController:  UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}


extension CurrencyViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
//        print(contentOffsetY)
        if contentOffsetY >= -2 {
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            flowLayout.sectionHeadersPinToVisibleBounds = true
        } else if contentOffsetY < -2 {
            collectionView.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
            flowLayout.sectionHeadersPinToVisibleBounds = false
        }
        
    }
    
    
}
