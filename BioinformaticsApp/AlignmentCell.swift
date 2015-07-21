//
//  AlignmentCell.swift
//  BioinformaticsApp
//
//  Created by Lizhen Shi on 7/20/15.
//  Copyright (c) 2015 Lizhen Shi. All rights reserved.
//

import UIKit

class AlignmentCell: UITableViewCell {

    @IBOutlet var seq1Label: UILabel!
    @IBOutlet var seq2Label: UILabel!
    
    var seq1: String = "" {
        didSet {
            if (seq1 != oldValue) {
                seq1Label.text = seq1
            }
        }
    }
    
    var seq2: String = "" {
        didSet {
            if (seq2 != oldValue) {
                seq2Label.text = seq2
            }
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
