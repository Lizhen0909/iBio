//
//  AlignmentResultViewController.swift
//  BioinformaticsApp
//
//  Created by Lizhen Shi on 7/20/15.
//  Copyright (c) 2015 Lizhen Shi. All rights reserved.
//

import UIKit

class AlignmentResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let tableIdentifier = "alignmentResultTableIdentifier"
    
    var score_matrix:String!
    var score_gap:Int!
    var global_alignment:Bool=true
    var s1:String!
    var s2:String!
    var align1:String!
    var align2:String!
    var score:Int!
    var tableData:[(String,String)]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        let nib = UINib(nibName: "AlignmentCell", bundle: nil)
        tableView.registerNib(nib,
            forCellReuseIdentifier: tableIdentifier)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        self.updateUI()
        self.makeTableData()
     }
    
    func rotated()   {
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation)) {
            self.makeTableData()
            tableView.reloadData()
        }
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))  {
            self.makeTableData()
            tableView.reloadData()
        }
    }
    
    func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func updateUI() {
        var scorefun:((Character,Character)->Int)!
        if score_matrix == "BLOSUM62" {
            scorefun=BLOSUM62
        } else {
            scorefun=PAM250
        }
        
        var score:Int
        var align1:String
        var align2:String
        if !global_alignment {
            self.title="Local Alignment"
            let la = LocalAlignment(s1: s1, s2: s2, scorefun: scorefun, gap: score_gap)
            (score,align1,align2)=la.eval()
        } else {
            self.title="Global Alignment"
            let ga = GlobalAlignment(s1: s1, s2: s2, scorefun: scorefun, gap: score_gap)
            (score,align1,align2)=ga.eval()
        }
        
        self.titleLabel.text="\(score_matrix) Score: \(score)"
        self.align1=align1
        self.align2=align2
        self.score=score
    }
    
    func makeTableData(){
       let lineLength:Int=getLineLength()
       self.tableData=[]
        let length=count(align1)
        var i=0
        while i<length {
            var sublen=lineLength
            if i+lineLength > length {
                sublen=length-i
            }
            let sub1 = (align1 as NSString).substringWithRange(NSRange(location: i, length: sublen))
            let sub2 = (align2 as NSString).substringWithRange(NSRange(location: i, length: sublen))
            tableData.append((sub1 as String,sub2 as String))
            i = i + lineLength
        }
    }
    
    func getLineLength()->Int{
        if isLandscapeOrientation(){
            return 50
        } else {
            return 25
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if isLandscapeOrientation() {
            return   120.0
        } else {
            return   155.0
        }
    }
    
    func isLandscapeOrientation() -> Bool {
        return UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation)
    }

    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(
            tableIdentifier) as! AlignmentCell
        let rowdata=self.tableData[indexPath.row]
        cell.seq1=rowdata.0
        cell.seq2=rowdata.1
        return cell
    }
}
