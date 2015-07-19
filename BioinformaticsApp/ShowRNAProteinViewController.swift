//
//  ShowRNAProteinViewController.swift
//  BioinformaticsApp
//
//  Created by Lizhen Shi on 7/19/15.
//  Copyright (c) 2015 Lizhen Shi. All rights reserved.
//

import UIKit

class ShowRNAProteinViewController: UIViewController {

    @IBOutlet weak var seqText: UITextView!
    var dnaString:String!
    var type:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if type == "RNA" {
            self.title="RNA Translation"
            seqText.text=dna_to_rna(dnaString)
            
        } else if type == "PROT" {
            self.title="Protein Translation"
            seqText.text=dna_to_protein(dnaString)
        }

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
