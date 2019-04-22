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
//    var currencyNames = [String]()
    
    var collectionView: UICollectionView!
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
    var userEnterAmount = Double()
    
    override func viewDidLoad() {
        
        allQuotesWithName = currencyViewModel.getQuotes()
        allNamesArray = currencyViewModel.getQuotesKey()
        selectedNamesArray = currencyViewModel.lastSelectedName()
        
        selectedQuotesArray = currencyViewModel.lastSelectedQuotes()
        selectedAmountArray = currencyViewModel.lastSelectedAmount()
        
        self.view.backgroundColor = UIColor.ciDarkGunMetal
        
        flowLayout.sectionInset = UIEdgeInsets(top: 40, left: 0, bottom: 10, right: 0)
        flowLayout.itemSize = CGSize(width: self.view.frame.width * 0.8 , height: 64)
        flowLayout.minimumLineSpacing = CGFloat(integerLiteral: 30)
        flowLayout.minimumInteritemSpacing = CGFloat(integerLiteral: 10)
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical //預設
        flowLayout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 54)
        collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.register(CurrencyCollectionViewCell.self, forCellWithReuseIdentifier: "reuseCell")
        collectionView.register(NothingCollectionViewCell.self, forCellWithReuseIdentifier: "nothingCell")
        collectionView.backgroundColor = UIColor.ciDarkGunMetal
        
        collectionView.register(CurrencyHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 154).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        collectionView.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)//collectionView 底下滑到空間
        collectionView.setContentOffset(CGPoint(x: 0, y: -150), animated: false)// 手機上顯示collectionView顯示的部分
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        numberPadHeight = self.view.frame.height * 0.4
//        numberPadView = NumberPad(frame: CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.width, height: numberPadHeight))
//        numberPadView.numberPadDelegate = self
        
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
                        self.selectedAmountArray.append(0)
                        
                        if self.selectedNamesArray.count < 10 {
                            self.selectedNamesArray.append("")
                            print(self.selectedNamesArray)
                        }
                        
//                        self.selectedAmountArray = self.currencyViewModel.calculateAllAmount(
//                            inAmount: self.userEnterAmount,
//                            selectedNames: self.selectedNamesArray,
//                            selectedQuotes:self.selectedQuotesArray,
//                            indexPath: indexPath )
    
                        self.reloadData()
                    }
                }
                
            }
            
            return nothingCell
        } else {
            var inRate = 0.0
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseCell", for: indexPath) as! CurrencyCollectionViewCell
            
            cell.rateImage.image = UIImage(named: "\(selectedNamesArray[indexPath.row])")
            cell.rateName.text = selectedNamesArray[indexPath.row]
//            if selectedAmountArray.count > 0 {
            cell.rateAmount.text = "\(selectedAmountArray[indexPath.row].roundToDecimal(2))"
//            }
            cell.smallBackViewTapHandler = { (bool) in //偵測到user點擊國家幣別
                if bool == true {
                    let vc = RateTypePicker()
                    vc.lastSelectedName = self.selectedNamesArray[indexPath.row]
                    
                    vc.modalTransitionStyle = .crossDissolve
                    self.present(vc, animated: true, completion: nil)
                    
                    vc.returnSelectName = { (flag,name) in
                        if flag == true {
                            //show selected rate name
                            cell.rateName.text = name
                            //add name into selectedNamesArray
                            self.selectedNamesArray[indexPath.row] = name
                            //base on name findout the rate
                            inRate = self.allQuotesWithName["USD\(name)"] ?? 0
                            //save to selectedQuotes
                            self.selectedQuotesArray[indexPath.row] = inRate
                        }
                    }
                    
                }
            }
            
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
                            
                            self.userEnterAmount = double
                            self.selectedAmountArray = self.currencyViewModel.calculateAllAmount(
                                inAmount: self.userEnterAmount,
                                selectedNames: self.selectedNamesArray,
                                selectedQuotes:self.selectedQuotesArray,
                                indexPath: indexPath )
                            cell.rateAmount.text = "\(self.selectedAmountArray[indexPath.row])"
                            
                        }else {
//                            cell.rateAmount.text = String(0)
                            
                        }
                        self.reloadData()
                    }
                }
                
            }
            return cell
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as! CurrencyHeaderCollectionReusableView
    
        return view
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func reloadData() {
        
        print("reloadData")
        print("selectedQuotesArray: \(selectedQuotesArray)")
        print("selectedNamesArray: \(selectedNamesArray)")
        print("selectedAmountArray: \(selectedAmountArray)")
        
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
        print(contentOffsetY)
        if contentOffsetY >= -10 {
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            flowLayout.sectionHeadersPinToVisibleBounds = true
        } else if contentOffsetY <= -10 {
            collectionView.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
            flowLayout.sectionHeadersPinToVisibleBounds = false
        }
        
    }
    
    
}
