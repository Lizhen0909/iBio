//
//  RootTableTableViewController.swift
//  BioinformaticsApp
//
//  Created by Lizhen Shi on 7/18/15.
//  Copyright (c) 2015 Lizhen Shi. All rights reserved.
//

import UIKit

class RootTableViewController: UITableViewController {

    var sequences : [DNASequence]!
    
    let seqTableIdentifier = "seqTableIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.configNavigationItems()
        
        
        let nib = UINib(nibName: "DNASeqCell", bundle: nil)
        tableView.registerNib(nib,
            forCellReuseIdentifier: seqTableIdentifier)
            

        
        let filePath = dataFilePath()
        if (NSFileManager.defaultManager().fileExistsAtPath(filePath)) {
          sequences=readFromFile(filePath)
        } else{
            sequences=[]
            sequences.append(readFastaEmbeded("JX069768"))
            sequences.append(readFastaEmbeded("JX469983"))
            sequences.append(readFastaEmbeded("FJ817486"))
            writeToFile(filePath, self.sequences)
        }
        
        let app = UIApplication.sharedApplication()
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "applicationWillResignActive:",
            name: UIApplicationWillResignActiveNotification,
            object: app)
        
    }
    
    func applicationWillResignActive(notification:NSNotification) {
        let filePath = dataFilePath()
        writeToFile(filePath,self.sequences)
    }
    
    func configNavigationItems(){
        let newimage=UIImage(named: "new")
        var newButton = UIBarButtonItem(image: newimage, style: .Plain, target: self, action: Selector("addNewSequence"))
        let downloadimage=UIImage(named: "download")
        var downloadButton = UIBarButtonItem(image: downloadimage, style: .Plain, target: self, action: Selector("addNewAlbum"))

        var editButton=editButtonItem()
        //editButton.image=UIImage(named: "edit")
        self.navigationItem.setLeftBarButtonItems([newButton,downloadButton], animated: false)
        self.navigationItem.setRightBarButtonItems([editButton], animated: false)
    }
    
    func addNewSequence() {
        performSegueWithIdentifier("DNASeqDetail", sender: nil)
    }
    
    func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    func reload() {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        self.reload()
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

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let sender = tableView.cellForRowAtIndexPath(indexPath)
        performSegueWithIdentifier("DNASeqDetail", sender: sender)
    }
    
    override func tableView(tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath) {
            
            if editingStyle == UITableViewCellEditingStyle.Delete {
                // Delete the row from the data source
                sequences.removeAtIndex(indexPath.row)
                //self.writeToFile(dataFilePath())
                tableView.deleteRowsAtIndexPaths([indexPath],
                    withRowAnimation: UITableViewRowAnimation.Fade)
            }
    }

    
    // MARK: Navigation
    
    func sequenceForDisplay(atIndexPath indexPath: NSIndexPath) -> DNASequence {
        return sequences[indexPath.row]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        let editVC = segue.destinationViewController as! EditDNASeqViewController
        
        editVC.rootView=self
        if (sender != nil){
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
            editVC.index = indexPath.row
            editVC.sequence = sequenceForDisplay(atIndexPath: indexPath)
        } else {
            let seq = DNASequence()
            editVC.index = -1
            editVC.sequence = seq
            
        }
        
    }

}
