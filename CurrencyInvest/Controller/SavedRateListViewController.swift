//
//  SavedRateListViewController.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/4/26.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import UIKit

class SavedRateListViewController: UIViewController {
    
    var exchangeList = [Exchange]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        tableView.backgroundColor = UIColor.black
        closeBtn.tintColor = UIColor.ciButtonGreen
    }
    
    
    func setData() {
        
        tableView.delegate = self
        tableView.dataSource = self
        exchangeList = CoreDataManager.sharedInstance.getExcahngeList()
        
    }

    @IBAction func closeBtnTapped(_ sender: UIButton) {
        
        self.dismiss(animated: true) {
            
        }
        
    }
    
}

extension SavedRateListViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            CoreDataManager.sharedInstance.deleteOneFromExchangeList(exchange: exchangeList[indexPath.row])
            
            exchangeList.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
            
        }
    }
    
    
}


extension SavedRateListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchangeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
        cell.setData(with: exchangeList, indexPath: indexPath)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        
    }
    
    
    
    
}
