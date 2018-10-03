//
//  ScheduledDeliveryTimeTableViewCell.swift
//  DemoPageViewController
//
//  Created by Đinh Ngọc Vũ on 10/2/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import UIKit
import DLRadioButton

protocol ScheduledDeliveryTimeTableViewCellDelegate: NSObjectProtocol {
    func onSelectedButton(_ tableViewCell: ScheduledDeliveryTimeTableViewCell, buttonInCellAt indexPath: IndexPath)
}
class ScheduledDeliveryTimeTableViewCell: UITableViewCell {
    @IBOutlet weak var selectedRadioButton: DLRadioButton!
    @IBOutlet weak var timeLabel: UILabel!
    weak var delegate: ScheduledDeliveryTimeTableViewCellDelegate?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func onSelected(_ sender: DLRadioButton) {
        if let indexPath = indexPath {
            delegate?.onSelectedButton(self, buttonInCellAt: indexPath)
        }
    }
    
}
