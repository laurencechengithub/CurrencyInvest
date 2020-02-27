//
//  bitCoinCollectionViewCell.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/3/4.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import UIKit
import Charts

class bitCoinCollectionViewCell: UICollectionViewCell {
    
    var bitCoinCellLabelPrice:CountingLabel!
    var bitCoinCellLabelType = UILabel()
    var histryLineGraph = LineChartView()
    var backGradientView:GradientView!
    var coinImageView = UIImageView()

    
    let months = ["Jan" , "Feb", "Mar", "Apr", "May", "June", "July", "August", "Sept", "Oct", "Nov", "Dec"]
    let unitsSold = [24.0,43.0,56.0,23.0,56.0,68.0,48.0,120.0,41.0,34.0,55.9,12.0,34.0,39.2,21.5,35.7,89.1,34.7]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        setData()
        setView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView() {
        
        self.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.cornerRadius = 5
        
        self.contentView.addSubview(bitCoinCellLabelType)
        self.contentView.addSubview(coinImageView)
        self.contentView.addSubview(histryLineGraph)
        
        coinImageView.translatesAutoresizingMaskIntoConstraints = false
        coinImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30).isActive = true
        coinImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 30).isActive = true
        coinImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        coinImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        bitCoinCellLabelType.translatesAutoresizingMaskIntoConstraints = false
        bitCoinCellLabelType.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: 10).isActive = true
        bitCoinCellLabelType.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 30).isActive = true
        bitCoinCellLabelType.heightAnchor.constraint(equalToConstant: 64).isActive = true
        bitCoinCellLabelType.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -30).isActive = true
//        bitCoinCellLabelType.widthAnchor.constraint(equalToConstant: 104).isActive = true
        bitCoinCellLabelType.backgroundColor = UIColor.clear
        bitCoinCellLabelType.textAlignment = .left
        bitCoinCellLabelType.font = UIFont.boldSystemFont(ofSize: 30)
        bitCoinCellLabelType.textColor = UIColor.white
//        bitCoinCellLabelType.padding = UIEdgeInsets.init(top: <#T##CGFloat#>, left: <#T##CGFloat#>, bottom: <#T##CGFloat#>, right: <#T##CGFloat#>)
        
   
        histryLineGraph.translatesAutoresizingMaskIntoConstraints = false
        histryLineGraph.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        histryLineGraph.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20).isActive = true
        histryLineGraph.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: -40).isActive = true
        histryLineGraph.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5).isActive = true
        histryLineGraph.backgroundColor = UIColor.black
    }
    
    
    func setCellLabelWith(typeArray:[String], priceArray:[Double], indexPath:IndexPath) {
        
        
        bitCoinCellLabelType.text = typeArray[indexPath.row]
        coinImageView.image = UIImage(named: typeArray[indexPath.row])
        
        bitCoinCellLabelPrice = CountingLabel(startValue: 0, endValue: priceArray[indexPath.row], duration: 1)
        self.contentView.addSubview(bitCoinCellLabelPrice)
        
        bitCoinCellLabelPrice.backgroundColor = UIColor.clear
        bitCoinCellLabelPrice.translatesAutoresizingMaskIntoConstraints = false
        bitCoinCellLabelPrice.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 100).isActive = true
        bitCoinCellLabelPrice.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15).isActive = true
        bitCoinCellLabelPrice.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -315).isActive = true
        bitCoinCellLabelPrice.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15 ).isActive = true
        bitCoinCellLabelPrice.textAlignment = .right
        
        
    }
    
    func setChartData(typeArray:[String],indexPath:IndexPath) {

        if typeArray[indexPath.row] == "BTC" {
            self.drawLineChart(dataSetName: typeArray[indexPath.row], value: Global.historyBTCValue)
            } else if typeArray[indexPath.row] == "ETH" {
            self.drawLineChart(dataSetName: typeArray[indexPath.row], value: Global.historyETHValue)
            } else if typeArray[indexPath.row] == "LTC" {
            self.drawLineChart(dataSetName: typeArray[indexPath.row], value: Global.historyLTCValue)
            } else if typeArray[indexPath.row] == "XMR" {
            self.drawLineChart(dataSetName: typeArray[indexPath.row], value: Global.historyXMRValue)
            } else if typeArray[indexPath.row] == "XRP" {
            self.drawLineChart(dataSetName: typeArray[indexPath.row], value: Global.historyXRPValue)
            } else if typeArray[indexPath.row] == "ZEC" {
            self.drawLineChart(dataSetName: typeArray[indexPath.row], value: Global.historyZECValue)
            }
   }
    
    
    
    func drawLineChart (dataSetName: String, value: [Double]) {
            
        var dataEntries: [ChartDataEntry] = []
        
        
        for i in 0..<value.count {
            dataEntries.append(ChartDataEntry(x: Double(), y: value[i]))
        }
        
        
        let line = LineChartDataSet(entries: dataEntries, label: "\(dataSetName)")
        
        //線的樣式
        line.circleRadius = 1
        line.lineWidth = 2
        line.mode = .cubicBezier
        line.cubicIntensity = 0.2
        line.setColor(UIColor.red)
//        line.drawCirclesEnabled = false
        line.drawValuesEnabled = false
        
        //線底下區域的顏色
        let grdient = getGradientFilling()
        line.fill = Fill.fillWithLinearGradient(grdient, angle: 90)
        line.drawFilledEnabled = true
        
        
        let lineChartData = LineChartData(dataSet: line)
        
        self.histryLineGraph.leftAxis.axisLineColor = UIColor.white
        self.histryLineGraph.leftAxis.enabled = true
        self.histryLineGraph.rightAxis.enabled = false
        self.histryLineGraph.xAxis.enabled = true
        self.histryLineGraph.xAxis.drawGridLinesEnabled = false
        self.histryLineGraph.xAxis.labelPosition = .bottom
        self.histryLineGraph.leftAxis.gridColor = UIColor.clear
        self.histryLineGraph.data = lineChartData
       
    }
        
    
    /// Creating gradient for filling space under the line chart
     private func getGradientFilling() -> CGGradient {
         // Setting fill gradient color
         let coloTop = UIColor(red: 72/255, green: 52/255, blue: 212/255, alpha: 1).cgColor
//         let colorBottom = UIColor(red: 230/255, green: 155/255, blue: 210/255, alpha: 1).cgColor
        let colorBottom = UIColor.clear
         // Colors of the gradient
         let gradientColors = [coloTop, colorBottom] as CFArray
         // Positioning of the gradient
         let colorLocations: [CGFloat] = [0.7, 0.0]
         // Gradient Object
         return CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)!
     }
}



