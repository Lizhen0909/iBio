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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "AlignmentCell", bundle: nil)
        tableView.registerNib(nib,
            forCellReuseIdentifier: tableIdentifier)
        
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(
            tableIdentifier) as! AlignmentCell
        
        
        
        return cell
    }
}
