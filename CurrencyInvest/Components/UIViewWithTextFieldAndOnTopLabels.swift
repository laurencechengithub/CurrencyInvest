//
//  UIViewWithTextFieldAndOnTopLabels.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/4/26.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation
import UIKit


class UIViewWithTextFieldAndOnTopLabels: UIView {
    
    var name:String!
    var rate:Double!
    var amount:Double!
    var namelabel = UILabel()
    var amountLabel = UILabel()
    var backgdView = UIView()
    var okBtn = UIButton()

    var inputText = UITextField()
    
    init(frame: CGRect, name:String, rate:Double, amount:Double) {

        super.init(frame: frame)
        self.name = name
        self.rate = rate
        self.amount = amount
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        setupView()
    }
    
    func setupView() {
        
        self.addSubview(backgdView)
        
        self.backgdView.addSubview(namelabel)
        self.backgdView.addSubview(amountLabel)
        self.backgdView.addSubview(inputText)
        self.backgdView.addSubview(okBtn)
        
        
        backgdView.translatesAutoresizingMaskIntoConstraints = false
        backgdView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        backgdView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        backgdView.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true
        backgdView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        backgdView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        backgdView.layer.cornerRadius = 20
        
        let labelheight = self.frame.height / 2 - 40
        let labelWidth = self.frame.width / 3 - 25
        namelabel.translatesAutoresizingMaskIntoConstraints = false
        namelabel.leadingAnchor.constraint(equalTo: backgdView.leadingAnchor, constant: 10).isActive = true
        namelabel.topAnchor.constraint(equalTo: backgdView.topAnchor, constant: 10).isActive = true
        namelabel.widthAnchor.constraint(equalToConstant: labelWidth ).isActive = true
        namelabel.heightAnchor.constraint(equalToConstant: labelheight).isActive = true
        namelabel.text = self.name
        namelabel.backgroundColor = UIColor.ciDownArrowBlue
        namelabel.layer.cornerRadius = 10
        namelabel.layer.masksToBounds = true
        namelabel.textColor = UIColor.white
        namelabel.textAlignment = .center
        namelabel.font = UIFont.boldSystemFont(ofSize: 16)
        namelabel.shadowColor = UIColor.green
        namelabel.shadowOffset = CGSize(width: 10, height: 10)
        
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.leadingAnchor.constraint(equalTo: namelabel.trailingAnchor, constant: 10).isActive = true
        amountLabel.topAnchor.constraint(equalTo: backgdView.topAnchor, constant: 10).isActive = true
        amountLabel.trailingAnchor.constraint(equalTo: backgdView.trailingAnchor, constant: -10).isActive = true
        amountLabel.heightAnchor.constraint(equalToConstant: labelheight).isActive = true
        amountLabel.text = "\(self.amount ?? 0)"
        amountLabel.backgroundColor = UIColor.ciDownArrowBlue
        amountLabel.layer.cornerRadius = 10
        amountLabel.layer.masksToBounds = true
        amountLabel.textColor = UIColor.white
        amountLabel.padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        amountLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        
        inputText.translatesAutoresizingMaskIntoConstraints = false
        inputText.bottomAnchor.constraint(equalTo: backgdView.bottomAnchor, constant: -10).isActive = true
        inputText.leadingAnchor.constraint(equalTo: backgdView.leadingAnchor, constant: 10).isActive = true
        inputText.widthAnchor.constraint(equalToConstant: labelWidth * 3).isActive = true
        inputText.heightAnchor.constraint(equalToConstant: labelheight).isActive = true
        inputText.placeholder = "Pls Enter title"
        inputText.layer.borderWidth = 1
        inputText.layer.borderColor = UIColor.ciDownArrowBlue.cgColor
        inputText.textColor = UIColor.ciDownArrowBlue
        inputText.layer.cornerRadius = 20
        inputText.setLeftPaddingPoints(15)
        
        
        okBtn.translatesAutoresizingMaskIntoConstraints = false
        okBtn.leadingAnchor.constraint(equalTo: inputText.trailingAnchor, constant: 5).isActive = true
        okBtn.heightAnchor.constraint(equalTo: inputText.heightAnchor, constant: 0).isActive = true
        okBtn.bottomAnchor.constraint(equalTo: backgdView.bottomAnchor, constant: -10).isActive = true
        okBtn.
    }
    
    
    
}
