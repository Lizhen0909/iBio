//
//  RootTableTableViewController.swift
//  BioinformaticsApp
//
//  Created by Lizhen Shi on 7/18/15.
//  Copyright (c) 2015 Lizhen Shi. All rights reserved.
//

import UIKit

class RootTableViewController: UITableViewController {

    private var sequences : [DNASequence]!
    
    let seqTableIdentifier = "seqTableIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.configNavigationItems()
        
        
        let nib = UINib(nibName: "DNASeqCell", bundle: nil)
        tableView.registerNib(nib,
            forCellReuseIdentifier: seqTableIdentifier)
            
        sequences=[]
        sequences.append(readFastaEmbeded("JX069768"))
        sequences.append(readFastaEmbeded("JX469983"))
        
    }
    
    func configNavigationItems(){
        let newimage=UIImage(named: "new")
        var newButton = UIBarButtonItem(image: newimage, style: .Plain, target: self, action: Selector("addNewAlbum"))
        let downloadimage=UIImage(named: "download")
        var downloadButton = UIBarButtonItem(image: downloadimage, style: .Plain, target: self, action: Selector("addNewAlbum"))

        var editButton=editButtonItem()
        editButton.image=UIImage(named: "edit")
        self.navigationItem.setLeftBarButtonItems([newButton,downloadButton], animated: false)
        self.navigationItem.setRightBarButtonItems([editButton], animated: false)
    }
    
    func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sequences.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(
            seqTableIdentifier) as! DNASeqCell
        
        let rowdata=sequences[indexPath.row]
        cell.id=rowdata.accession
        cell.version=rowdata.version
        cell.desc=rowdata.description
        
        return cell
    }
    

    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if isLandscapeOrientation() {
        return   120.0
    } else {
        return   155.0
        }
    }
    
    func isLandscapeOrientation() -> Bool {
        return UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation)
    }

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
