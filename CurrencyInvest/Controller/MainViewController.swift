//
//  MainViewController.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/2/26.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
//    var segmentControl: AnimatedSegmentControl!
    let controlView = UIView()
    var controlViewImage = UIImageView()
    
    var bitLabel = UILabel()
    var underLine = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        
        let viewWidth = self.view.frame.width
//        let viewHeight = self.view.frame.height
        
        self.view.addSubview(bitLabel)
        
        bitLabel.translatesAutoresizingMaskIntoConstraints = false
        bitLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        bitLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        bitLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        bitLabel.heightAnchor.constraint(equalToConstant: 66).isActive = true
        bitLabel.text = "Money X Bit"
        bitLabel.textAlignment = .left
        bitLabel.font = UIFont.boldSystemFont(ofSize: 36)
        bitLabel.textColor = UIColor.white
        
        self.view.addSubview(underLine)
        underLine.backgroundColor = UIColor.white
        underLine.translatesAutoresizingMaskIntoConstraints = false
        underLine.topAnchor.constraint(equalTo: bitLabel.bottomAnchor, constant: -10).isActive = true
        underLine.leadingAnchor.constraint(equalTo: bitLabel.leadingAnchor, constant: 20).isActive = true
        underLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        underLine.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20).isActive = true
        
        
        self.view.addSubview(controlView)
        self.view.bringSubviewToFront(controlView)
        controlView.translatesAutoresizingMaskIntoConstraints = false
        controlView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        controlView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        controlView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        controlView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        controlView.backgroundColor = UIColor.white.withAlphaComponent(0)
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(changeView))
        controlView.addGestureRecognizer(tapGesture)
        
        controlView.addSubview(controlViewImage)
        controlViewImage.translatesAutoresizingMaskIntoConstraints = false
        controlViewImage.centerXAnchor.constraint(equalTo: controlView.centerXAnchor).isActive = true
        controlViewImage.centerYAnchor.constraint(equalTo: controlView.centerYAnchor).isActive = true
        controlViewImage.widthAnchor.constraint(equalTo: controlView.widthAnchor, multiplier: 0.7).isActive = true
        controlViewImage.heightAnchor.constraint(equalTo: controlView.heightAnchor, multiplier: 0.7).isActive = true
        controlViewImage.image = UIImage(named: "bitChangeRate")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    
//    @objc func segmentControlValueChanged() {
//
//        if segmentControl.selectedIndex == 0 { //select currency
//
//            if Global.isBitCoinPageShlowing == true {
//
//                Global.isBitCoinPageShlowing = false
//
//                self.dismiss(animated: true, completion: nil)
//
//            } else {
//                print("Currency page is now showing")
//
//            }
//            segmentControl.selectedIndex = 0
//
//        } else {
//
//            if Global.isBitCoinPageShlowing == false {
//                Global.isBitCoinPageShlowing = true
//                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let BitCoinVC = mainStoryboard.instantiateViewController(withIdentifier: "BitCoinViewController") as! BitCoinViewController
////                BitCoinVC.modalPresentationStyle = .custom//會導致segment control 無法跳到segment 0
//                BitCoinVC.modalTransitionStyle = .crossDissolve
//                self.present(BitCoinVC, animated: true, completion: nil)
//            } else {
//                print("bitcoin page is now showing")
//            }
//        }
//
//
//    }
    
    
    
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

extension MainViewController {
    
    @objc func changeView() {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let BitCoinVC = mainStoryboard.instantiateViewController(withIdentifier: "BitCoinViewController") as! BitCoinViewController
        BitCoinVC.modalTransitionStyle = .crossDissolve
        self.present(BitCoinVC, animated: true, completion: nil)
        
        print("tapped")
        
    }
    
    
}
