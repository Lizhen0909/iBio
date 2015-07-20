//
//  EditDNASeqViewController.swift
//  BioinformaticsApp
//
//  Created by Lizhen Shi on 7/18/15.
//  Copyright (c) 2015 Lizhen Shi. All rights reserved.
//

import UIKit

class EditDNASeqViewController: UIViewController,UITextViewDelegate {

    var rootView: RootTableViewController!
    var index: Int!
    var sequence: DNASequence!
    var saveButton: UIBarButtonItem!
    var saveEdit: Bool = false
    @IBOutlet weak var accessionText: UITextField!
    @IBOutlet weak var descText: UITextField!
    @IBOutlet weak var versionText: UITextField!
    @IBOutlet weak var seqText: UITextView!
    
    @IBOutlet weak var toRNAButton: UIBarButtonItem!
    @IBOutlet weak var toProteinButton: UIBarButtonItem!
    @IBOutlet weak var kmerProfileButton: UIBarButtonItem!
    @IBOutlet weak var alignmentButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = saveButtonItem(self.index<0)
  
        self.seqText.layer.borderWidth = CGFloat(5.0)
        self.seqText.layer.borderColor =  UIColor.redColor() as! CGColor
        //self.seqText.layer.cornerRadius = 8;

        // Do any additional setup after loading the view.
        self.accessionText.text=sequence.accession
        self.descText.text=sequence.description
        self.versionText.text=sequence.version
        self.seqText.text=sequence.sequence
        
        accessionText.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        descText.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        versionText.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        seqText.delegate = self
        
    }

    func textFieldDidChange(textField: UITextField) {
        self.saveButton.enabled=true
    }
    
    func textViewDidChange(textView: UITextView){
        self.saveButton.enabled=true
    }
    
    func saveButtonItem(enabled:Bool) ->UIBarButtonItem {
         let saveImage=UIImage(named: "save")
        saveButton = UIBarButtonItem(image: saveImage, style: .Plain, target: self, action: Selector("savePressed"))
        saveButton.enabled=enabled
        return saveButton
    }
    
    func savePressed() {
  
        var hasError=false
        var errMsg=""
        if accessionText.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())=="" {
            hasError=true
            errMsg="Accession Id cannot be empty!"
        }
        if let newSeqText=validateSequence(seqText.text) {
             seqText.text=newSeqText.uppercaseString
        } else {
            hasError=true
            errMsg="Only ACGT or acgt can be in sequence!"
        }
        
        if hasError {
            showError(errMsg)
        } else {
            self.saveEdit = true
            self.navigationController?.popViewControllerAnimated(true)
  
        }
    }
    
    func showError(errMsg:String){
        let controller2 = UIAlertController(
        title:"Error",
        message: errMsg, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "OK",
        style: .Default, handler: nil)
        controller2.addAction(cancelAction)
        self.presentViewController(controller2, animated: true,
        completion: nil)
    }
    
    
    override func willMoveToParentViewController(parent: UIViewController?) {
        if (!(parent?.isEqual(self.parentViewController) ?? false)) {
            if (saveEdit){
                sequence.accession=accessionText.text
                sequence.version=versionText.text
                sequence.description=descText.text
                sequence.sequence=seqText.text
                if (index<0){
                    rootView.sequences.append(sequence)
                } else {
                    rootView.sequences[index]=sequence
                }
                writeToFile(dataFilePath(),rootView.sequences)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func backgroundTap(sender: UIControl) {
        descText.resignFirstResponder()
        versionText.resignFirstResponder()
        seqText.resignFirstResponder()
    }

    
    
    // MARK: - Navigation
    
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
         
            if let newSeqText=validateSequence(seqText.text) {
                seqText.text=newSeqText.uppercaseString
            } else {
                let errMsg="Only ACGT or acgt can be in sequence!"
                showError(errMsg)
                return false
            }
        
         
        // by default, transition
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "RNAtoDNAIdnetifier"  ||  segue.identifier == "RNAtoProteinIdnetifier" {
            let editVC = segue.destinationViewController as! ShowRNAProteinViewController
            editVC.dnaString=seqText.text
            if segue.identifier == "RNAtoDNAIdnetifier" {
                editVC.type="RNA"
            } else {
                editVC.type="PROT"
            }
            
        } else if segue.identifier == "kmerProfileIdentifier" {
            let editVC = segue.destinationViewController as! KmerTabViewController
            editVC.dnaString=seqText.text
            
        }
    }
    

}
