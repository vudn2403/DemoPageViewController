//
//  ScheduledDeliveryDayTableViewCell.swift
//  DemoPageViewController
//
//  Created by Đinh Ngọc Vũ on 10/2/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import UIKit

class ScheduledDeliveryDayTableViewCell: UITableViewCell {
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUp()
    }
    
    func setUp() {
        let date = Date()
        datePicker.minimumDate = date
        datePicker.setDate(date, animated: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
