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
    func getNumberWith(numString:String)
    func okBtnTapped(bool:Bool)
}


class NumberPad : UIView {
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        print(self.frame)
//        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        print(self.frame)
        setupView()
        
    }
    
    var numberPadDelegate:NumberPadDelegate!
    var btnCollectionView:UICollectionView!
    var OkBtnTappedHandler : ((Bool)->())?
    
    enum KeyBoardBtnType: Int, CaseIterable {
        
        case One = 1
        case Two
        case Three
        case Four
        case Five
        case Six
        case Seven
        case Eight
        case Nine
        case Back
        case Zero
        case Ok
        
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
                case .Back:
                    //                    return "BIRTHDAY_REWRITE".localized
                    return "Del."
                case .Zero:
                    return "0"
                case .Ok:
                    return "OK"
                    
                }
                
            }
        }
        
    }
    
    func setupView() {

        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 0, right: 2)
  
        let itemSizeWidth = (self.frame.width - 10)/3
        let itemSizeHeight = (self.frame.height - 10)/4
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
  
//        if let selectedString = KeyBoardBtnType.init(rawValue: indexPath.row + 1)?.description {
//            numberPadDelegate.getNumberWith(numString: selectedString)
//
//            if selectedString == "OK" {
//                numberPadDelegate.okBtnTapped(bool: true)
//            }
//
//            print(" selectedString \(selectedString)")
//        }
        
        
        if let selectedKeyBoardBtnType = KeyBoardBtnType.init(rawValue: indexPath.row + 1) {
            
            switch selectedKeyBoardBtnType {
            case .Ok:
                numberPadDelegate.okBtnTapped(bool: true)
            case .Back:
                print("more")
            default:
                let selectedString = selectedKeyBoardBtnType.description
                numberPadDelegate.getNumberWith(numString: selectedString)
            }
            
            
        }
        
        
        
    }
}


extension NumberPad: UICollectionViewDataSource {
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
        
        contentView.backgroundColor = UIColor.ciDeepKoamaru
//        contentView.layer.borderWidth = 2
//        contentView.layer.borderColor = UIColor.reNavigationBarRed.cgColor
        contentView.layer.cornerRadius = 6
        
        numLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        numLabel.backgroundColor = UIColor.clear
        numLabel.textAlignment = .center
        numLabel.textColor = UIColor.ciMaize
        numLabel.font = UIFont.boldSystemFont(ofSize: 34)
        numLabel.center = contentView.center
        
        self.contentView.addSubview(numLabel)
    }
    
}
