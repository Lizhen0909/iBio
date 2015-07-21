//
//  AlignmentSettingsViewController.swift
//  BioinformaticsApp
//
//  Created by Lizhen Shi on 7/20/15.
//  Copyright (c) 2015 Lizhen Shi. All rights reserved.
//

import UIKit

class AlignmentSettingsViewController: UIViewController  {
    @IBOutlet weak var firstSeqId: UITextField!
    @IBOutlet weak var firstProtSeq: UITextField!
    @IBOutlet weak var secondSeqId: UITextField!
    @IBOutlet weak var secondChooseButton: UIButton!
    @IBOutlet weak var secondProtSeq: UITextField!
    @IBOutlet weak var scoreMatrixCtl: UISegmentedControl!
    @IBOutlet weak var TypeSegCtl: UISegmentedControl!
    @IBOutlet weak var gapText: UITextField!
    @IBOutlet weak var goButton: UIButton!

    var this_sequence:DNASequence!
    var second_sequence:DNASequence?
    var all_sequences:[DNASequence]!
    var score_matrix="BLOSUM62"
    var global_alignment=true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func toggleControls(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.score_matrix="BLOSUM62"
        } else {
            self.score_matrix="PAM250"
        }
    }
    
    @IBAction func toggleTypeControls(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.global_alignment=true
        } else {
            self.global_alignment=false
        }
    }
    
    func setSeqFields(){
        firstSeqId.text=this_sequence.accession
        firstProtSeq.text=dna_to_protein(this_sequence.sequence)
        if second_sequence != nil {
            secondSeqId.text=second_sequence!.accession
            secondProtSeq.text=dna_to_protein(second_sequence!.sequence)
        }

    }

    override func viewDidAppear(animated: Bool) {
        self.setSeqFields()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func backgroundTap(sender: UIControl) {
        gapText.resignFirstResponder()
    }
    
    
    // MARK: - Navigation
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
    
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        var errMsg:String=""
        if identifier == "alignmentResultIdentifier" {
            if count(firstProtSeq.text) < 1 || count(secondProtSeq.text) < 1 {
                errMsg="Did you miss selecting a seq? Or one of the sequences has zero length."
                showError(errMsg)
                return false
            }
        
            if let gapscore=gapText.text.toInt() {
                if gapscore > 0 {
                    return true
                }
            }
            errMsg="Gap score should be a positive integer"
            showError(errMsg)
            return false

       }
        
        // by default, transition
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "alignmentChooseIdentifier" {
            let editVC = segue.destinationViewController as! AlignmentChooseViewController
            editVC.all_sequences=self.all_sequences
            editVC.settingsVC=self
            
        }else if segue.identifier == "alignmentResultIdentifier" {
            let editVC = segue.destinationViewController as! AlignmentResultViewController
            editVC.score_matrix=self.score_matrix
            editVC.global_alignment=self.global_alignment
            editVC.score_gap = -gapText.text.toInt()!
            editVC.s1=firstProtSeq.text
            editVC.s2=secondProtSeq.text
            
        }
        
    }

}
