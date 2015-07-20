//
//  KmerSettingsViewController.swift
//  BioinformaticsApp
//
//  Created by Lizhen Shi on 7/19/15.
//  Copyright (c) 2015 Lizhen Shi. All rights reserved.
//

import UIKit

class KmerSettingsViewController: UIViewController {

    @IBOutlet weak var seqText: UITextView!
    
    @IBOutlet weak var kmerSizeText: UITextField!
    
    @IBOutlet weak var updateButton: UIButton!
    
    var dnaString:String!
    
    var kmerList:[String]!
    
    @IBAction func updatePressed(sender: UIButton) {
      calculate()
    }
 
    func calculate() {
        
        if let kmersize = kmerSizeText.text.toInt() {
            kmerList=kmer_generate(kmersize, dnaString)
            updateButton.enabled=false
        } else {
            return showError("k-mer size is not an integer.")
        }
        
    }

    func textFieldDidChange(textField: UITextField) {
        self.updateButton.enabled=true
    }
    
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func backgroundTap(sender: UIControl) {
        kmerSizeText.resignFirstResponder()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.kmerSizeText.text="4"
        self.updateButton.enabled=false
        let superControler = self.tabBarController as! KmerTabViewController
        self.dnaString=superControler.dnaString
        self.seqText.text=superControler.dnaString
        kmerSizeText.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
            calculate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
