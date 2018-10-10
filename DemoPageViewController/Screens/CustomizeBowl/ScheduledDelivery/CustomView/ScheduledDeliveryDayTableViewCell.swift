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
        datePicker.addTarget(self, action: #selector(onDatePickerValueChange(_:)), for: UIControlEvents.valueChanged)
    }
    
    @objc func onDatePickerValueChange(_ datePicker: UIDatePicker) {
        if datePicker.date.timeIntervalSince1970 < (datePicker.minimumDate?.timeIntervalSince1970)! {
            datePicker.setDate(Date(), animated: true)
        }
        let dateFM = DateFormatter()
        dateFM.dateFormat = "dd-MM-yyyy HH:mm:ss a"
        print(dateFM.string(from: datePicker.date))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}


