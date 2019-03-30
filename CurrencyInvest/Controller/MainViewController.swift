//
//  MainViewController.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/2/26.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var segmentControl: AnimatedSegmentControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        
        let viewWidth = self.view.frame.width
//        let viewHeight = self.view.frame.height
        var segmentControlWidth = viewWidth - 20
        segmentControl = AnimatedSegmentControl(frame: CGRect(x: 10, y: 10, width: segmentControlWidth, height: 48))
        self.view.addSubview(segmentControl)
        
        segmentControl.items = ["Currency", "BitCoin"]
        segmentControl.borderColor = UIColor.lightGray
        segmentControl.selectedLabelColor = .black
        segmentControl.unselectedLabelColor = .ciMaize
        segmentControl.backgroundColor = UIColor.clear
        segmentControl.thumbColor = .ciMaize
        segmentControl.selectedIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if Global.isBitCoinPageShlowing == true {
            segmentControl.selectedIndex = 1
        }else {
            segmentControl.selectedIndex = 0
        }
    }
    
    
    @objc func segmentControlValueChanged() {
        
        if segmentControl.selectedIndex == 0 {
            
            if Global.isBitCoinPageShlowing == true {
        
                Global.isBitCoinPageShlowing = false
                self.dismiss(animated: true, completion: nil)
    
            } else {
                print("Currency page is now showing")

            }
            
            
        } else {
            
            if Global.isBitCoinPageShlowing == false {
                Global.isBitCoinPageShlowing = true
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let BitCoinVC = mainStoryboard.instantiateViewController(withIdentifier: "BitCoinViewController") as! BitCoinViewController
                BitCoinVC.modalTransitionStyle = .flipHorizontal
                self.present(BitCoinVC, animated: true, completion: nil)
            } else {
                print("bitcoin page is now showing")
            }
        }
        
        
    }
    
    
    
//    @IBAction func bitCoinBtnTapped(_ sender: UIButton) {
//
//        if Global.isBitCoinPageShlowing == false {
//
//            Global.isBitCoinPageShlowing = true
//            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let BitCoinVC = mainStoryboard.instantiateViewController(withIdentifier: "BitCoinViewController") as! BitCoinViewController
//            BitCoinVC.modalTransitionStyle = .flipHorizontal
//            self.present(BitCoinVC, animated: true, completion: nil)
//
//        } else {
//            print("bitcoin page is now showing")
//        }
//
//    }
//
//
//    @IBAction func currencyBtnTapped(_ sender: UIButton) {
//
//        if Global.isBitCoinPageShlowing == true {
//
//            Global.isBitCoinPageShlowing = false
//            self.dismiss(animated: true, completion: nil)
//
//        } else {
//            print("Currency page is now showing")
//
//        }
//
//
//
//
//    }

}
