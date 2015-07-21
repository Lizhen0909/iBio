//
//  KmerFreqViewController.swift
//  BioinformaticsApp
//
//  Created by Lizhen Shi on 7/20/15.
//  Copyright (c) 2015 Lizhen Shi. All rights reserved.
//

import UIKit

class KmerProfileViewController: UITableViewController {

    var settingsVC:KmerSettingsViewController!
    var tableData:[(Int,Float)]!
    
    let tableIdentifier = "kmerProfileTableICell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barViewControllers = self.tabBarController?.viewControllers
        self.settingsVC = barViewControllers![0] as! KmerSettingsViewController
        self.updateTableData()
        self.title="Counting Freq"
    }
    
    func updateTableData(){
        self.tableData=[]
        let kmers=settingsVC.kmerList
        let profile=kmer_profile(kmers)
        for (cnt,cntCount) in profile {
            self.tableData.append((cnt,cntCount))
        }
        self.tableData.sort({$0.0<$1.0})
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
        return tableData.count+1
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(
            tableIdentifier) as! UITableViewCell
        if indexPath.row==0 {
            cell.detailTextLabel?.font=UIFont.boldSystemFontOfSize(15.0)
            cell.textLabel?.font=UIFont.boldSystemFontOfSize(15.0)
            cell.textLabel?.text="Count"
            cell.detailTextLabel?.text="Freq"

        } else {
            cell.detailTextLabel?.font=UIFont(name:"Courier New", size: 13.0)
            cell.textLabel?.font=UIFont(name:"Courier New", size: 13.0)

            let rowdata=tableData[indexPath.row-1]
            cell.textLabel?.text=rowdata.0.description
            let strFloat=NSString(format: "%.2f%%", rowdata.1*100)
            cell.detailTextLabel?.text=strFloat as? String
        }
        return cell
    }
}
