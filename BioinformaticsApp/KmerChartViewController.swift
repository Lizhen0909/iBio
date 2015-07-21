//
//  KmerChartViewController.swift
//  BioinformaticsApp
//
//  Created by Lizhen Shi on 7/20/15.
//  Copyright (c) 2015 Lizhen Shi. All rights reserved.
//

import UIKit
import Charts

class KmerChartViewController: UIViewController {

    @IBOutlet var barChartView: BarChartView!
    
    var settingsVC:KmerSettingsViewController!
    var tableData:[(Int,Float)]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Counting Chart"
        let barViewControllers = self.tabBarController?.viewControllers
        self.settingsVC = barViewControllers![0] as! KmerSettingsViewController
        self.updateTableData()
        
        self.setChart()
        

    }
    
    func updateTableData(){
        self.tableData=[]
        let kmers=settingsVC.kmerList
        let profile=kmer_profile(kmers)
        let cntArray = profile.keys.array
        let maxcnt=maxElement(cntArray)
        for i in 0..<maxcnt {
            self.tableData.append((Int(i+1),Float(0.0)))
        }
        for (cnt,cntCount) in profile {
            self.tableData[cnt-1]=((cnt,cntCount))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.updateTableData()
        self.setChart()
    }
    
    func setChart() {
        barChartView.noDataText = "You need to provide data for the chart."
        
        
        var dataEntries: [BarChartDataEntry] = []
        var dataPoints:[String]=[]
        for i in 0..<self.tableData.count {
            let dataEntry = BarChartDataEntry(value: Double(Int(tableData[i].1*10000))/100.0, xIndex: i)
            dataEntries.append(dataEntry)
            dataPoints.append(tableData[i].0.description)
        }
        

        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Profile")
        let chartData = BarChartData(xVals: dataPoints, dataSet: chartDataSet)
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        barChartView.data = chartData
        barChartView.descriptionText = ""
        barChartView.xAxis.labelPosition = .Bottom
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
