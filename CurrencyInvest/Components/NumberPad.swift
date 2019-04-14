//
//  NumberPad.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/1/18.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation
import UIKit

protocol NumberPadDelegate {
    func numberTapped(numString:String,numInt:Int)
    func okBtnTapped(bool:Bool)
    func kBtnTapped(numString : String)
    func tenkBtnTapped(numString:String)
    func hundredBtnTapped(numString:String)
    func plusBtnTapped(bool:Bool)
    func minusBtnTapped(bool:Bool)
    func divideBtnTapped(bool:Bool)
    func multiplyBtnTapped(bool:Bool)
    func deleteBtnTapped(bool:Bool)
    func dotBtnTapped(bool:Bool)
}


class NumberPad : UIView {
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        print(self.frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
//        print(self.frame)
//        setupView()
        
    }
    
    var numberPadDelegate:NumberPadDelegate!
    var btnCollectionView:UICollectionView!
    var OkBtnTappedHandler : ((Bool)->())?
    var itemSizeWidth:CGFloat!
    var itemSizeHeight:CGFloat!
    
    enum KeyBoardBtnType: Int, CaseIterable {
        
        case One = 1
        case Two = 2
        case Three = 3
        case Delete = 4
        case plus = 5
        
        case Four = 6
        case Five = 7
        case Six = 8
        case K = 9
        case minus = 10
        
        case Seven = 11
        case Eight = 12
        case Nine = 13
        case TenK = 14
        case multiply = 15
        
        case Zero = 16
        case Dot = 17
        case Ok = 18
        case HundredK = 19
        case divide = 20
        
        //static var count: Int { return Keyboard.Ok.rawValue}
        
        var description : String {
            
            get {
                
                switch(self) {
                case .One:
                    return "1"
                case .Two:
                    return "2"
                case .Three:
                    return "3"
                case .Four:
                    return "4"
                case .Five:
                    return "5"
                case .Six:
                    return "6"
                case .Seven:
                    return "7"
                case .Eight:
                    return "8"
                case .Nine:
                    return "9"
                case .Delete:
                    return "←"
                case .Zero:
                    return "0"
                case .Ok:
                    return "OK"
                case .Dot:
                    return "."
                case .K:
                    return "K"
                case .TenK:
                    return "10K"
                case .HundredK:
                    return "100K"
                case .plus:
                    return "+"
                case .minus:
                    return "−"
                case .multiply:
                    return "×"
                case .divide:
                    return "÷"
                }
                
            }
        }
        
    }
    
    func setupView() {

        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 0, right: 2)
  
        itemSizeWidth = (self.frame.width - 10)/4
        itemSizeHeight = (self.frame.height - 10)/4
        print(itemSizeWidth)
        print(itemSizeHeight)
        flow.itemSize = CGSize(width: itemSizeWidth, height: itemSizeHeight)
        flow.minimumLineSpacing = 3
        flow.minimumInteritemSpacing = 1
        
        btnCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0 , width: self.frame.width , height: self.frame.height), collectionViewLayout: flow)
        btnCollectionView.register(NumberPadCollectionViewCell.self, forCellWithReuseIdentifier: "PadBtnCell")
        btnCollectionView.delegate = self
        btnCollectionView.dataSource = self
        btnCollectionView.backgroundColor = UIColor.ciDarkGunMetal
        
        self.addSubview(btnCollectionView)
        
    }
    
    
    
}

extension NumberPad: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let selectedKeyBoardBtnType = KeyBoardBtnType.init(rawValue: indexPath.row + 1) {
            
            switch selectedKeyBoardBtnType {
            case .Ok:
                numberPadDelegate.okBtnTapped(bool: true)
            case .K:
                numberPadDelegate.kBtnTapped(numString: "000")
            case .TenK:
                numberPadDelegate.tenkBtnTapped(numString: "0000")
            case .Dot:
                numberPadDelegate.dotBtnTapped(bool: true)
            case .HundredK:
                numberPadDelegate.hundredBtnTapped(numString: "00000")
            case .Delete:
                numberPadDelegate.deleteBtnTapped(bool: true)
            case .divide:
                numberPadDelegate.divideBtnTapped(bool: true)
            case .minus:
                numberPadDelegate.minusBtnTapped(bool: true)
            case .multiply:
                numberPadDelegate.multiplyBtnTapped(bool: true)
            case .plus:
                numberPadDelegate.plusBtnTapped(bool: true)
            default:
                let selectedString = selectedKeyBoardBtnType.description
                let selectedInt = selectedKeyBoardBtnType.rawValue
                numberPadDelegate.numberTapped(numString: selectedString, numInt: selectedInt)
            }
        }
    }
    
    
}


extension NumberPad: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return KeyBoardBtnType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PadBtnCell", for: indexPath) as! NumberPadCollectionViewCell
        
        if let BtnString = KeyBoardBtnType.init(rawValue: indexPath.row + 1 )?.description {
            cell.numLabel.text = BtnString
        }
        
        
        return cell
        
    }
}


//extension NumberPad: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        if indexPath.row == 14 {
//            return CGSize(width: itemSizeWidth * 2 + 2, height: itemSizeHeight)
//        }
//
//        return CGSize(width: itemSizeWidth, height: itemSizeHeight)
//
//    }
//
//}



class NumberPadCollectionViewCell: UICollectionViewCell {
    
    var numLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        
//        contentView.backgroundColor = UIColor.ciDeepKoamaru
        contentView.backgroundColor = UIColor.ciJet
        
//        contentView.layer.borderWidth = 2
//        contentView.layer.borderColor = UIColor.reNavigationBarRed.cgColor
        contentView.layer.cornerRadius = 20
        
        numLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        numLabel.backgroundColor = UIColor.clear
        numLabel.textAlignment = .center
        numLabel.textColor = UIColor.ciMaize
        numLabel.font = UIFont.boldSystemFont(ofSize: 34)
        numLabel.center = contentView.center
        
        self.contentView.addSubview(numLabel)
    }
    
}
