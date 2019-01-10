//
//  DropDownBtn.swift
//  re
//
//  Created by Laurence  Chen on 2018/11/5.
//  Copyright © 2018 Re Corporation Limited. All rights reserved.
//

import Foundation
import UIKit

protocol dropDownViewProtocol {
    func selectedCountryWith (Name:String , Index:Int)

}

protocol dropDownBtnProtocol {
    func getFinalSelectionFrom (theIndex:Int, sender:DropDownBtn)

}

class DropDownBtn: UIButton, dropDownViewProtocol {
    
    func selectedCountryWith(Name: String, Index: Int) {
        self.setTitle(Name, for: .normal)
        dropDownBtnDelegate.getFinalSelectionFrom(theIndex: Index, sender: self)
        dismissDropDown()
    }
    
    var dropView = DropDownView()
    var dropViewHeight = NSLayoutConstraint()
    var isOpened = false
    var dropDownBtnDelegate:dropDownBtnProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addTarget(self, action: #selector(dropDownControl), for: .touchUpInside)

        dropView.dropDownViewDelegate = self
        dropView.backgroundColor = UIColor.clear
        dropView.layer.borderWidth = 1
        dropView.layer.cornerRadius = 5
        dropView.layer.borderColor = UIColor.lightGray.cgColor
        dropView.translatesAutoresizingMaskIntoConstraints = false

    }
    
    override func didMoveToSuperview() {
        
        if let superview = self.superview {
            
            superview.addSubview(dropView)
            superview.bringSubviewToFront(dropView)
            dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            dropViewHeight = dropView.heightAnchor.constraint(equalToConstant: 0)
            
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dropDownControl() {
        if isOpened == false {
            
            openDropDown ()
            
        } else {
            
            dismissDropDown()
            
        }
    }
    
    @objc func dismissDropDown() {
        
        isOpened = false
        self.dropViewHeight.constant = 0
        NSLayoutConstraint.activate([self.dropViewHeight])
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropView.center.y -= self.dropView.frame.height / 2
            self.dropView.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    func openDropDown () {
        
        isOpened = true
        if self.dropView.itemListTableView.contentSize.height > 100 {
            self.dropViewHeight.constant = 100
        } else {
            self.dropViewHeight.constant = self.dropView.itemListTableView.contentSize.height
        }
        NSLayoutConstraint.activate([self.dropViewHeight])
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropView.layoutIfNeeded()
            self.dropView.center.y += self.dropView.frame.height / 2
        }, completion: nil)
        
    }
    
}

class DropDownView: UIView,UITableViewDelegate,UITableViewDataSource {
    
    let itemListTableView = UITableView()
    var itemList = [String]()
    var dropDownViewDelegate:dropDownViewProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.itemListTableView.delegate = self
        self.itemListTableView.dataSource = self
        itemListTableView.layer.cornerRadius = 5
        itemListTableView.backgroundColor = UIColor.white
        itemListTableView.showsVerticalScrollIndicator = false
        itemListTableView.showsHorizontalScrollIndicator = false
        
        self.addSubview(itemListTableView)
        self.bringSubviewToFront(itemListTableView)
        itemListTableView.translatesAutoresizingMaskIntoConstraints = false
        itemListTableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        itemListTableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        itemListTableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        itemListTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = UITableViewCell()
        cell.textLabel?.text = itemList[indexPath.row]
        cell.textLabel?.textColor = UIColor.lightGray
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = UIColor.white
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dropDownViewDelegate.selectedCountryWith(Name: itemList[indexPath.row], Index: indexPath.row)
        self.itemListTableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
