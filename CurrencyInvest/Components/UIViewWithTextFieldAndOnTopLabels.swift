//
//  UIViewWithTextFieldAndOnTopLabels.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/4/26.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class UIViewWithTextFieldAndOnTopLabels: UIView {
    
    var name:String!
    var rate:Double!
    var amount:Double!
    var namelabel = UILabel()
    var amountLabel = UILabel()
    var backgdView = UIView()
    var okBtn = UIButton()
    var commet:String = ""
    var inputText = UITextField()
    var okBtnTappedWithComment:((Bool,String)->())!
    
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
        
        let labelheight = (self.frame.height - 80) / 3
        let labelWidth = (self.frame.width - 25) / 3
        namelabel.translatesAutoresizingMaskIntoConstraints = false
        namelabel.leadingAnchor.constraint(equalTo: backgdView.leadingAnchor, constant: 10).isActive = true
        namelabel.topAnchor.constraint(equalTo: backgdView.topAnchor, constant: 20).isActive = true
        namelabel.widthAnchor.constraint(equalToConstant: labelWidth ).isActive = true
        namelabel.heightAnchor.constraint(equalToConstant: labelheight).isActive = true
        namelabel.text = self.name
        namelabel.backgroundColor = UIColor.ciDownArrowBlue
        namelabel.layer.cornerRadius = 10
        namelabel.layer.masksToBounds = true
        namelabel.textColor = UIColor.white
        namelabel.textAlignment = .center
        namelabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.leadingAnchor.constraint(equalTo: namelabel.trailingAnchor, constant: 10).isActive = true
        amountLabel.topAnchor.constraint(equalTo: backgdView.topAnchor, constant: 20).isActive = true
        amountLabel.trailingAnchor.constraint(equalTo: backgdView.trailingAnchor, constant: -20).isActive = true
        amountLabel.heightAnchor.constraint(equalToConstant: labelheight).isActive = true
        amountLabel.text = "\(self.amount ?? 0)"
        amountLabel.backgroundColor = UIColor.ciDownArrowBlue
        amountLabel.layer.cornerRadius = 10
        amountLabel.layer.masksToBounds = true
        amountLabel.textColor = UIColor.white
        amountLabel.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        amountLabel.font = UIFont.boldSystemFont(ofSize: 20)
        amountLabel.textAlignment = .right
        
        inputText.translatesAutoresizingMaskIntoConstraints = false
        inputText.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 20).isActive = true
        inputText.leadingAnchor.constraint(equalTo: backgdView.leadingAnchor, constant: 10).isActive = true
        inputText.widthAnchor.constraint(equalToConstant: labelWidth * 3).isActive = true
        inputText.heightAnchor.constraint(equalToConstant: labelheight).isActive = true
        inputText.placeholder = "Pls Enter Comment"
        inputText.layer.borderWidth = 1
//        inputText.layer.borderColor = UIColor.ciDownArrowBlue.cgColor
        inputText.textColor = UIColor.white
        inputText.layer.cornerRadius = 10
        inputText.setLeftPaddingPoints(15)
        inputText.backgroundColor = UIColor.darkGray
        inputText.font = UIFont.boldSystemFont(ofSize: 20)
//        inputText.layer.shadowOpacity = 0.5
//        inputText.layer.shadowColor = UIColor.white.cgColor
//        inputText.layer.shadowRadius = 10
//        inputText.layer.masksToBounds = false
        
        okBtn.translatesAutoresizingMaskIntoConstraints = false
        okBtn.leadingAnchor.constraint(equalTo: backgdView.leadingAnchor, constant: 100).isActive = true
        okBtn.heightAnchor.constraint(equalToConstant: labelheight).isActive = true
        okBtn.topAnchor.constraint(equalTo: inputText.bottomAnchor, constant: 20).isActive = true
        okBtn.trailingAnchor.constraint(equalTo: backgdView.trailingAnchor, constant: -100).isActive = true
        okBtn.addTarget(self, action: #selector(okBtnTapped), for: .touchUpInside)
        okBtn.backgroundColor = UIColor.ciButtonGreen
        okBtn.setTitle("OK", for: .normal)
        okBtn.layer.cornerRadius = 10
        
    }
    
    @objc func okBtnTapped() {
        
        if let text = inputText.text {
            self.commet = text
            okBtnTappedWithComment(true,self.commet)
        } else {
            okBtnTappedWithComment(false,"")
        }
        
    }
    
    
}
