//
//  RecipientSavedInfoTableViewCell.swift
//  DemoPageViewController
//
//  Created by Đinh Ngọc Vũ on 10/2/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import UIKit
import DLRadioButton

protocol RecipientSavedInfoTableViewCellDelegate: NSObjectProtocol {
    func onSelectedButton(_ tableViewCell: RecipientSavedInfoTableViewCell, buttonInCellAt indexPath: IndexPath)
}

class RecipientSavedInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var selectedRadioButton: DLRadioButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    weak var delegate: RecipientSavedInfoTableViewCellDelegate?
    var indexPath: IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func onSelected(_ sender: Any) {
        if let indexPath = indexPath {
            delegate?.onSelectedButton(self, buttonInCellAt: indexPath)
        }
    }
    
}
