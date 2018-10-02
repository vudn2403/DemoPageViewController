//
//  RecipientSavedInfoTableViewCell.swift
//  DemoPageViewController
//
//  Created by Đinh Ngọc Vũ on 10/2/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import UIKit
import DLRadioButton

class RecipientSavedInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedView.layer.cornerRadius = selectedView.frame.width/2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        selectedView.isHidden = selected ? false : true
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
