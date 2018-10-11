//
//  Orders.swift
//  DemoPageViewController
//
//  Created by Đinh Ngọc Vũ on 10/10/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import Foundation

class OrdersModel {
    var ordersDetails: [OrdersDetailModel]
    
    init() {
        self.ordersDetails = [OrdersDetailModel]()
    }
    
    static var sharedInstance: OrdersModel = {
        let instance = OrdersModel()
        return instance
    }()
}
