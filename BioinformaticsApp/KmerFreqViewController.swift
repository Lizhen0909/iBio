//
//  KmerFreqViewController.swift
//  BioinformaticsApp
//
//  Created by Lizhen Shi on 7/19/15.
//  Copyright (c) 2015 Lizhen Shi. All rights reserved.
//

import UIKit

class KmerFreqViewController: UITableViewController {

    var settingsVC:KmerSettingsViewController!
    var tableData:[(String,Float)]!
    
    let tableIdentifier = "kmerFreqTableIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barViewControllers = self.tabBarController?.viewControllers
        self.settingsVC = barViewControllers![0] as! KmerSettingsViewController
        self.updateTableData()
        self.title="k-mer Freq"
    }
    
    func updateTableData(){
        self.tableData=[]
        let kmers=settingsVC.kmerList
        let kmerFreq=kmer_freq(kmers)
        for (kmer,freq) in kmerFreq {
            self.tableData.append((kmer,freq))
        }
        self.tableData.sort({$0.1>$1.1})
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        self.updateTableData()
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(
            tableIdentifier) as! UITableViewCell
        
        let rowdata=tableData[indexPath.row]
        cell.textLabel?.text=rowdata.0
        let strFloat=NSString(format: "%.2f%%", rowdata.1*100)
        cell.detailTextLabel?.text=strFloat as? String
        
        return cell
    }
}
