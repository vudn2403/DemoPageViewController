//
//  BowlViewModel.swift
//  DemoPageViewController
//
//  Created by Đinh Ngọc Vũ on 10/8/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import Foundation

class BowlViewModel {
    var recipient: RecipientModel?
    var scheduleDelivery: ScheduleDeliveryModel?
    
    static var shareInstance: BowlViewModel = {
        let instance = BowlViewModel()
        return instance
    }()
    
    func clearData() {
        recipient = nil
        scheduleDelivery = nil
    }
}
