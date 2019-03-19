//
//  MainViewController.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/2/26.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabelWithPadding!
    @IBOutlet weak var bitCoinBtn: UIButton!
    @IBOutlet weak var currencyBtn: UIButton!
    
//    var bitCoinVC = BitCoinViewController()
//    var currencyVC = CurrencyViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = UIFont.boldSystemFont(ofSize: 46)
        titleLabel.textColor = UIColor.ciIsabelline
        
        bitCoinBtn.setBackgroundImage(UIImage(named: "bitCoin"), for: .normal)
        currencyBtn.setBackgroundImage(UIImage(named: "coin"), for: .normal)
//        bitCoinBtn.layer.cornerRadius = 25
//        bitCoinBtn.layer.borderWidth = 3
//        bitCoinBtn.layer.borderColor = UIColor.ciMaize.cgColor
        
//        currencyBtn.layer.cornerRadius = 25
//        currencyBtn.layer.borderWidth = 3
//        currencyBtn.layer.borderColor = UIColor.ciMaize.cgColor
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Global.isBitCoinPageShlowing == true {
            titleLabel.text = "BitCoin"
        }else {
            titleLabel.text = "Currency"
        }
    }
    
    
    @IBAction func bitCoinBtnTapped(_ sender: UIButton) {
        
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
    
    
    @IBAction func currencyBtnTapped(_ sender: UIButton) {
        
        if Global.isBitCoinPageShlowing == true {
            
            Global.isBitCoinPageShlowing = false
            self.dismiss(animated: true, completion: nil)
            
        } else {
            print("Currency page is now showing")
            
        }
        

        

    }

}
