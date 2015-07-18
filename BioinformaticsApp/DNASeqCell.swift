//
//  DNASeqCellTableViewCell.swift
//  BioinformaticsApp
//
//  Created by Lizhen Shi on 7/18/15.
//  Copyright (c) 2015 Lizhen Shi. All rights reserved.
//

import UIKit

class DNASeqCell: UITableViewCell {

    @IBOutlet var idLabel: UILabel!
    @IBOutlet var versionLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    
    var id: String = "" {
        didSet {
            if (id != oldValue) {
                idLabel.text = id
            }
        }
    }
    
    var version: String = "" {
        didSet {
            if (version != oldValue) {
                versionLabel.text = version
            }
        }
    }
    
    var desc: String = "" {
        didSet {
            if (desc != oldValue) {
                descLabel.text = desc
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
