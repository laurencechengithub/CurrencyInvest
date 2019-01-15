//
//  NumberPadViewController.swift
//  re
//
//  Created by Laurence  Chen on 2018/9/13.
//  Copyright © 2018 Re Corporation Limited. All rights reserved.
//

import Foundation
import UIKit

protocol NumberPadViewControllerDelegate: class {
    func getBirthDayFrom(year:String,month:String,day:String)
}

class NumberPadViewController: UIViewController {
    
    var centerView:UIView!
    var topLabel:UILabel!
    var labelYear:UILabel!
    var labelMonth:UILabel!
    var labelDay:UILabel!
    var btnCollectionView:UICollectionView!
    var closeBtn:UIButton!
    var isDeleteBtnFuntion = false
    
    var existBirthDay: String = ""

    enum FocusLabelType {
        
        case Year
        case Month
        case Day
        case None

    }
    
    enum Keyboard: Int, CaseIterable {

        case One = 1
        case Two
        case Three
        case Four
        case Five
        case Six
        case Seven
        case Eight
        case Nine
        case Retest
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
                case .Retest:
//                    return "BIRTHDAY_REWRITE".localized
                    return "reset"
                case .Zero:
                    return "0"
                case .Ok:
                    return "OK"

                }
                
            }
        }
        
    }
    
    var focusLabelType:FocusLabelType = .Year {
        didSet{
//            highlightLabel()
        }
    }

    weak var selfDesignDelegate : BirthDayViewControllerDelegate?
    
    override func viewDidLoad() {
        
        initView()
        
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    func initView() {
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        centerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width * 0.9, height: view.frame.height * 0.8))
        centerView.backgroundColor = UIColor.darkGray
        //centerView.layer.borderColor = UIColor.navigationBarRed.cgColor
        //centerView.layer.borderWidth = 3
        centerView.layer.cornerRadius = 6
        
        closeBtn = UIButton(frame: CGRect(x: centerView.frame.maxX - 50, y: 10, width: 40, height: 40))
        closeBtn.backgroundColor = UIColor.white
        closeBtn.setTitleColor(UIColor.darkGray, for: .normal)
//        closeBtn.addTarget(self, action: #selector(), for: .touchUpInside)
        
        topLabel = UILabel(frame: CGRect(x: 10, y: closeBtn.frame.maxY, width: centerView.frame.width - 20, height: 40))
        topLabel.backgroundColor = UIColor.white
        topLabel.text = "aaa"
        topLabel.textAlignment = .center
        topLabel.textColor = .darkGray
        topLabel.font = UIFont.boldSystemFont(ofSize: 26)
        
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let itemSizeWidth = (centerView.frame.width - 90)/3
        flow.itemSize = CGSize(width: itemSizeWidth + 20, height: itemSizeWidth)
        flow.minimumLineSpacing = 3
        flow.minimumInteritemSpacing = 1
    
        let btnCollectionViewVerticalBlank:CGFloat = 10 + closeBtn.frame.height + topLabel.frame.height + topLabel.frame.height + 10
        btnCollectionView = UICollectionView(frame: CGRect(x: 10, y: topLabel.frame.maxY + 5 , width: centerView.frame.width - 20 , height: centerView.frame.height - btnCollectionViewVerticalBlank), collectionViewLayout: flow)
        btnCollectionView.register(BirthDayBtnCollectionViewCell.self, forCellWithReuseIdentifier: "BirthDayCell")
        btnCollectionView.delegate = self
        btnCollectionView.dataSource = self
        btnCollectionView.backgroundColor = UIColor.white
        
        self.view.addSubview(centerView)
        self.centerView.addSubview(closeBtn)
        self.centerView.addSubview(topLabel)
        self.centerView.addSubview(btnCollectionView)
        
        centerView.center = view.center
   
    }


}
    
    
extension NumberPadViewController : UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Keyboard.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BirthDayCell", for: indexPath) as! BirthDayBtnCollectionViewCell
        
//        if let keyboard = Keyboard.init(rawValue: indexPath.row + 1) {
//
//            cell.numLabel.text = keyboard.description
//
//            if keyboard == .Retest {
//                cell.numLabel.font = UIFont.boldSystemFont(ofSize: 20)
//            }
//
//            if keyboard == .Ok {
//                cell.numLabel.font = UIFont.boldSystemFont(ofSize: 20)
//                cell.numLabel.textColor = UIColor.white
//                cell.contentView.backgroundColor = UIColor.navigationBarRed
//            }
//
//        }
        
        return cell
      
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        if let keyboard = Keyboard.init(rawValue: indexPath.row + 1) {
//
//            if keyboard == .Retest {
//
//                resetAllLabels()
//
//            } else if keyboard == .Ok {
//
//                completeBtnTapped()
//
//            } else {
//
//                let keyboard = Keyboard.init(rawValue: indexPath.row + 1)?.description
//                writeLabel(labelType: focusLabelType, number: keyboard!)
//
//            }
//        }
        
    }
    
}
