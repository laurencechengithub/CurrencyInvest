//
//  BitCoinViewController.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/2/26.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import UIKit

class BitCoinViewController: UIViewController {
    
    var bitCoinCollectionView:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func setUpView() {
        
        self.view.backgroundColor = UIColor.ciDarkGunMetal
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 40, left: 0, bottom: 10, right: 0)
        flowLayout.itemSize = CGSize(width: self.view.frame.width * 0.8 , height: 140)
        flowLayout.minimumLineSpacing = CGFloat(integerLiteral: 30)
        flowLayout.minimumInteritemSpacing = CGFloat(integerLiteral: 10)
        //            flowLayout.headerReferenceSize = CGSize(width: self.view.width, height: 50)
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical //預設
        bitCoinCollectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: flowLayout)
        bitCoinCollectionView.register(bitCoinCollectionViewCell.self, forCellWithReuseIdentifier: "reuseCell")
        bitCoinCollectionView.backgroundColor = UIColor.ciDarkGunMetal
        bitCoinCollectionView.delegate = self
        bitCoinCollectionView.dataSource = self
        
        self.view.addSubview(bitCoinCollectionView)
        
        bitCoinCollectionView.translatesAutoresizingMaskIntoConstraints = false
        bitCoinCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 154).isActive = true
        bitCoinCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bitCoinCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        bitCoinCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    
    }
    
}

extension BitCoinViewController: UICollectionViewDelegate {
    
    
}


extension BitCoinViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserDefualtManager.sharedInstance.localCryptoPriceArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseCell", for: indexPath) as! bitCoinCollectionViewCell
        
        cell.setCellLabelWith(typeArray: UserDefualtManager.sharedInstance.localCryptoTypeArray,
                              priceArray: UserDefualtManager.sharedInstance.localCryptoPriceArray,
                              indexPath: indexPath)
        
        return cell
    }
    
    
    
    
    
}
