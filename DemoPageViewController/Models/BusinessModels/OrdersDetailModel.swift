//
//  OrdersDetail.swift
//  DemoPageViewController
//
//  Created by Đinh Ngọc Vũ on 10/10/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import Foundation

class OrdersDetailModel {
    var foodModel: FoodModel
    var amount: Int
    
    init(foodModel: FoodModel, amount: Int) {
        self.foodModel = foodModel
        self.amount = amount
    }
}
