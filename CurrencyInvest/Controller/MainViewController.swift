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
    @IBOutlet weak var bitLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        
        let viewWidth = self.view.frame.width
//        let viewHeight = self.view.frame.height
        let segmentControlWidth = viewWidth - 140
        segmentControl = AnimatedSegmentControl(frame: CGRect(x: 70, y: 85, width: segmentControlWidth, height: 30))
        self.view.addSubview(segmentControl)
        
        segmentControl.items = ["Currency", "BitPrice"]
        segmentControl.borderColor = UIColor.clear
        segmentControl.selectedLabelColor = .black
        segmentControl.unselectedLabelColor = .ciMaize
        segmentControl.backgroundColor = UIColor.clear
        segmentControl.thumbColor = .ciMaize
        segmentControl.selectedIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(Global.isBitCoinPageShlowing)
        
        if Global.isBitCoinPageShlowing == true {
            segmentControl.selectedIndex = 1
        }else {
            segmentControl.selectedIndex = 0
        }
    }
    
    
    @objc func segmentControlValueChanged() {
        
        if segmentControl.selectedIndex == 0 { //select currency
            
            if Global.isBitCoinPageShlowing == true {
        
                Global.isBitCoinPageShlowing = false
                
                self.dismiss(animated: true, completion: nil)
                
            } else {
                print("Currency page is now showing")

            }
            segmentControl.selectedIndex = 0
            
        } else {
            
            if Global.isBitCoinPageShlowing == false {
                Global.isBitCoinPageShlowing = true
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let BitCoinVC = mainStoryboard.instantiateViewController(withIdentifier: "BitCoinViewController") as! BitCoinViewController
//                BitCoinVC.modalPresentationStyle = .custom//會導致segment control 無法跳到segment 0
                BitCoinVC.modalTransitionStyle = .crossDissolve
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
