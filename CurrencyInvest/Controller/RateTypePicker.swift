//
//  ResidenceViewController.swift
//  re
//
//  Created by Ken Chang on 2018/9/12.
//  Copyright © 2018年 Re Corporation Limited. All rights reserved.
//

import UIKit

protocol RateTypePickerDelegate: class {

    func getRate(name: String)

}

class RateTypePicker: UIViewController {
    

    
    var boardView: UIView = UIView()

    var nameLabel: UILabel = UILabel()
    var alphabetLabel: UILabel = UILabel()

    var alphabetTableView = UITableView()
    var rateNameTableView = UITableView()

    var selectedExist: String = ""

    var selectedAlphabetIndex: Int = 0
    var selectedTypeNameIndex: Int = 0

    //===
    var currencyVM = CurrencyViewModel()
    var masterNameArray = [String]()
    var matchNameArray = [String]()
    var isHaveSelectedName: Bool = false
    var lastSelectedName:String = ""
    var lastSelectedNamePrefix:String = String()
    var lastSelectedNameIndex:Int = Int()
    var lastSelectedAlphabetPrefix:String = String()
    var lastSelectedalphabetIndex:Int = Int()
    var tableViewWidth = CGFloat()
    var tableViewHeight = CGFloat()
    var returnSelectName:((Bool,String)->())!
    
    weak var rateTypePickerDelegate: RateTypePickerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)

        initData()
        initView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func initData() {
        
        masterNameArray = currencyVM.getQuotesKey()
        
        if lastSelectedName.isEmpty {
            
            //第一次進來 userdefault沒有直文字
            lastSelectedNameIndex = 0
            lastSelectedalphabetIndex = 0
            matchNameArray = masterNameArray
            
        } else {
            
            //進來有內容
            isHaveSelectedName = true
            
            //Show last name
            nameLabel.text = lastSelectedName
            
            //左邊要選擇highlight哪一個
            lastSelectedAlphabetPrefix = String(lastSelectedName.prefix(1)) //ex:CNY 的 "C"
            if let alphabetIndex = Global.alphabetArray.firstIndex(of: lastSelectedAlphabetPrefix) {
                lastSelectedalphabetIndex = alphabetIndex
                
            }
            
            //按照左邊字母塞篩選右邊
            matchNameArray = masterNameArray.filter({
                $0.hasPrefix(lastSelectedAlphabetPrefix)
            })
            
            //找出name在matchArray是第幾個index
            if let nameIndex = matchNameArray.firstIndex(of: lastSelectedName) {
                lastSelectedNameIndex = nameIndex
            }
    
            
        }

    }

    private func initView() {
        
        tableViewWidth = (self.view.frame.width - 80) / 2
        
        boardView = UIView()
        nameLabel = UILabel()
        alphabetTableView = UITableView()
        rateNameTableView = UITableView()
        let cancelBtn: UIButton = UIButton()
        let confirmBtn: UIButton = UIButton()
        let viewLine1: UIView = UIView()
        let viewLine2: UIView = UIView()
        
        self.view.addSubview(boardView)
        boardView.addSubview(cancelBtn)
        boardView.addSubview(confirmBtn)
        boardView.addSubview(nameLabel)
        boardView.addSubview(alphabetTableView)
        boardView.addSubview(rateNameTableView)
        boardView.addSubview(viewLine1)
        boardView.addSubview(viewLine2)
        
        
        
        boardView.translatesAutoresizingMaskIntoConstraints = false
        boardView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        boardView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        boardView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
        boardView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
        boardView.layer.cornerRadius = 20
        boardView.backgroundColor = UIColor.ciDarkGunMetal


        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        cancelBtn.topAnchor.constraint(equalTo: boardView.topAnchor, constant: 5).isActive = true
        cancelBtn.trailingAnchor.constraint(equalTo: boardView.trailingAnchor, constant: -5).isActive = true
        cancelBtn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        cancelBtn.widthAnchor.constraint(equalToConstant: 20).isActive = true
        cancelBtn.setTitleColor(UIColor.darkGray, for: .normal)
        cancelBtn.setTitle("✖︎", for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelbtn_tapped), for: .touchUpInside)
        

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: boardView.topAnchor, constant: 30).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: boardView.centerXAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 64).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 128).isActive = true
        nameLabel.textAlignment = .center
        nameLabel.text = isHaveSelectedName ? masterNameArray[selectedTypeNameIndex] : "Pick.."
        nameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        nameLabel.backgroundColor = UIColor.clear
        nameLabel.layer.cornerRadius = 5
        nameLabel.textColor = UIColor.ciMaize


        confirmBtn.translatesAutoresizingMaskIntoConstraints = false
        confirmBtn.leadingAnchor.constraint(equalTo: boardView.leadingAnchor, constant: 30).isActive = true
        confirmBtn.trailingAnchor.constraint(equalTo: boardView.trailingAnchor, constant: -30).isActive = true
        confirmBtn.bottomAnchor.constraint(equalTo: boardView.bottomAnchor, constant: -5).isActive = true
        confirmBtn.heightAnchor.constraint(equalToConstant: 54).isActive = true
        confirmBtn.setTitle("CONFIRM", for: .normal)
        confirmBtn.setTitleColor(UIColor.white, for: .normal)
        confirmBtn.backgroundColor = UIColor.ciButtonGreen
        confirmBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        confirmBtn.addTarget(self, action: #selector(confirmbtn_tapped), for: .touchUpInside)
        confirmBtn.layer.cornerRadius = 10
        
        let startRow:IndexPath = IndexPath(row: 0, section: 0)
        alphabetTableView.translatesAutoresizingMaskIntoConstraints = false
        alphabetTableView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        alphabetTableView.leadingAnchor.constraint(equalTo: boardView.leadingAnchor, constant: 0).isActive = true
        alphabetTableView.bottomAnchor.constraint(equalTo: boardView.bottomAnchor, constant: -84).isActive = true
        alphabetTableView.widthAnchor.constraint(equalToConstant: tableViewWidth).isActive = true
        alphabetTableView.delegate = self
        alphabetTableView.dataSource = self
        alphabetTableView.register(RateTypePickerAlphabetTableViewCell.self, forCellReuseIdentifier: "alphabetCell")
        let alphabetRow: IndexPath = IndexPath(row: lastSelectedalphabetIndex, section: 0)
//        alphabetTableView.scrollToRow(at: alphabetRow, at: .middle, animated: true)
        alphabetTableView.moveRow(at: startRow, to: alphabetRow)
        alphabetTableView.separatorStyle = .none
        alphabetTableView.showsVerticalScrollIndicator = false
        alphabetTableView.backgroundColor = UIColor.clear
        
        rateNameTableView.translatesAutoresizingMaskIntoConstraints = false
        rateNameTableView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        rateNameTableView.trailingAnchor.constraint(equalTo: boardView.trailingAnchor, constant: 0).isActive = true
        rateNameTableView.bottomAnchor.constraint(equalTo: boardView.bottomAnchor, constant: -84).isActive = true
        rateNameTableView.widthAnchor.constraint(equalToConstant: tableViewWidth).isActive = true
        rateNameTableView.delegate = self
        rateNameTableView.dataSource = self
        rateNameTableView.register(RateTypePickerAlphabetTableViewCell.self, forCellReuseIdentifier: "alphabetCell")
        let nameRow: IndexPath = IndexPath(row: lastSelectedNameIndex, section: 0)
//        rateNameTableView.scrollToRow(at: nameRow, at: .middle, animated: true)
        rateNameTableView.moveRow(at: startRow, to: nameRow)
        rateNameTableView.separatorStyle = .none
        rateNameTableView.showsVerticalScrollIndicator = false
        rateNameTableView.backgroundColor = UIColor.clear
        
        
        
        //垂直線
        viewLine1.translatesAutoresizingMaskIntoConstraints = false
        viewLine1.topAnchor.constraint(equalTo: alphabetTableView.topAnchor).isActive = true
        viewLine1.leadingAnchor.constraint(equalTo: alphabetTableView.trailingAnchor, constant: 0).isActive = true
        viewLine1.widthAnchor.constraint(equalToConstant: 1).isActive = true
        viewLine1.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.7).isActive = true
        viewLine1.backgroundColor = UIColor.ciButtonGreen
        boardView.bringSubviewToFront(viewLine1)
        
        //上橫線
        viewLine2.translatesAutoresizingMaskIntoConstraints = false
        viewLine2.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 1).isActive = true
        viewLine2.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: 0).isActive = true
        viewLine2.widthAnchor.constraint(equalToConstant: 128).isActive = true
        viewLine2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        viewLine2.backgroundColor = UIColor.ciButtonGreen
        boardView.bringSubviewToFront(viewLine2)


        //下橫線
//        let viewLine3: UIView = UIView(frame: CGRect(x: 0, y: rateNameTableView.frame.maxY + 4, width: boardViewWidth, height: 1))
//        viewLine3.backgroundColor = UIColor.darkGray
//        boardView.addSubview(viewLine3)
    }

    @objc func cancelbtn_tapped(sender: UIButton) {

        self.dismiss(animated: true, completion: nil)

    }

    @objc func confirmbtn_tapped(sender: UIButton) {

        self.dismiss(animated: true) {
            
//            self.rateTypePickerDelegate?.getRate(name: "\(self.nameLabel.text ?? "")")
//            self.returnSelectName(true,"\(self.nameLabel.text ?? "")")
            self.returnSelectName(true, "\(self.nameLabel.text ?? "error")")

        }
    }
}

extension RateTypePicker: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == alphabetTableView {
            return Global.alphabetArray.count
        } else {
            if isHaveSelectedName == true {
                return matchNameArray.count
            }else {
                return masterNameArray.count
            }
            
            
        }
        
//        return tableView == alphabetTableView ? alphabetArray.count : rateNameArray.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == alphabetTableView {

            let cell = tableView.dequeueReusableCell(withIdentifier: "alphabetCell") as! RateTypePickerAlphabetTableViewCell
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            
            //不管是不是第一次進 都要load全部字母
            cell.label.text = Global.alphabetArray[indexPath.row]

            if isHaveSelectedName {
                //已有選擇的時候把對應的字母hight light
                cell.haveSelected(indexInt: lastSelectedalphabetIndex, selected: indexPath.row == lastSelectedalphabetIndex ? true : false)
            } else {
                cell.haveSelected(indexInt: lastSelectedalphabetIndex, selected: indexPath.row == lastSelectedalphabetIndex ? true : false)
            }
            
            return cell

        } else {

            let cell = tableView.dequeueReusableCell(withIdentifier: "alphabetCell") as! RateTypePickerAlphabetTableViewCell
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
//            cell.setData(dataArray: rateNameArray, indexPath: indexPath)
            
            //clear all cell background color
            if lastSelectedNameIndex == 999 {
                cell.resetBackGroundColor()
            }
            
            if isHaveSelectedName == true {
                //如果不是第一次進來 就load match Array
                cell.label.text = matchNameArray[indexPath.row]
                cell.haveSelected(indexInt: lastSelectedNameIndex, selected: indexPath.row == lastSelectedNameIndex ? true : false)
            } else {
                //第一次勁近來 load master Array
                cell.label.text = masterNameArray[indexPath.row]
            }
            
            return cell

        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        isHaveSelectedName = true
        
        if tableView == alphabetTableView {
            
            //點選左邊
            lastSelectedalphabetIndex = indexPath.row
            
            alphabetTableView.reloadData()
            
            //右邊就要更新array
            if lastSelectedalphabetIndex == 0 {
                matchNameArray = masterNameArray
            } else {
                let targetAlphabet:String = Global.alphabetArray[lastSelectedalphabetIndex]
                matchNameArray = masterNameArray.filter({
                    $0.hasPrefix(targetAlphabet)
                })
            }
            


            
            //右邊index = 0
            lastSelectedNameIndex = 999

            nameLabel.text = ""
            
            rateNameTableView.reloadData()
            
//            let areaRow: IndexPath = IndexPath(row: selectedTypeNameIndex, section: 0)
//            rateNameTableView.scrollToRow(at: areaRow, at: .top, animated: true)

        } else if tableView == rateNameTableView {

            lastSelectedNameIndex = indexPath.row
            nameLabel.text = matchNameArray[lastSelectedNameIndex]
            rateNameTableView.reloadData()
        }

    }
}


