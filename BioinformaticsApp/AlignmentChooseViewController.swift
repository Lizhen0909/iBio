//
//  AlignmentChooseViewController.swift
//  BioinformaticsApp
//
//  Created by Lizhen Shi on 7/20/15.
//  Copyright (c) 2015 Lizhen Shi. All rights reserved.
//

import UIKit

class AlignmentChooseViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var selectButton: UIButton!
    
    var all_sequences:[DNASequence]!
    var settingsVC:AlignmentSettingsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        let row = picker.selectedRowInComponent(0)
        let selected = all_sequences[row]
        settingsVC.second_sequence=selected
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK:-
    // MARK: Picker Data Source Methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
            return 1
    }
    
    func pickerView(pickerView: UIPickerView,
            numberOfRowsInComponent component: Int) -> Int {
            return all_sequences.count
    }
    
    // MARK: Picker Delegate Methods
    func pickerView(pickerView: UIPickerView,
            titleForRow row: Int,
            forComponent component: Int) -> String! {
            return all_sequences[row].accession
    }

}
