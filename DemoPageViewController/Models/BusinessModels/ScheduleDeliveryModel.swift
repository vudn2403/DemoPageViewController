//
//  ScheduleDeliveryModel.swift
//  DemoPageViewController
//
//  Created by Đinh Ngọc Vũ on 10/8/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import Foundation

class ScheduleDeliveryModel {
    var date: Date
    var time: String
    var note: String
    
    init(_ date: Date, _ time: String, _ note: String) {
        self.date = date
        self.time = time
        self.note = note
    }
}
