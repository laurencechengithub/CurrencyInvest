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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear

        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = UIFont.boldSystemFont(ofSize: 46)
        titleLabel.textColor = UIColor.ciIsabelline
        titleLabel.text = "Currency"
        
        bitCoinBtn.layer.cornerRadius = 25
        bitCoinBtn.layer.borderWidth = 3
        bitCoinBtn.layer.borderColor = UIColor.ciMaize.cgColor
        
        currencyBtn.layer.cornerRadius = 25
        currencyBtn.layer.borderWidth = 3
        currencyBtn.layer.borderColor = UIColor.ciMaize.cgColor
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func bitCoinBtnTapped(_ sender: UIButton) {
        titleLabel.text = "BitCoin"
    }
    
    
    @IBAction func currencyBtnTapped(_ sender: UIButton) {
        titleLabel.text = "Currency"
    }
    
    


}
