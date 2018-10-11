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
        let food1 = FoodModel(id: "1", name: "Chicken", weight: 60, cost: 500, type: "Protein")
        let food2 = FoodModel(id: "2", name: "Ground Beef", weight: 60, cost: 500, type: "Protein")
        let food3 = FoodModel(id: "3", name: "Tofu", weight: 60, cost: 500, type: "Protein")
        let food4 = FoodModel(id: "4", name: "Basa", weight: 60, cost: 500, type: "Protein")
        let food5 = FoodModel(id: "5", name: "Egg", weight: 60, cost: 500, type: "Protein")
        let od1 = OrdersDetailModel(foodModel: food1, amount: 1)
        let od2 = OrdersDetailModel(foodModel: food2, amount: 2)
        let od3 = OrdersDetailModel(foodModel: food3, amount: 3)
        let od4 = OrdersDetailModel(foodModel: food4, amount: 4)
        let od5 = OrdersDetailModel(foodModel: food5, amount: 5)
        ordersDetails.append(od1)
        ordersDetails.append(od2)
        ordersDetails.append(od3)
        ordersDetails.append(od4)
        ordersDetails.append(od5)
    }
    
    static var sharedInstance: OrdersModel = {
        let instance = OrdersModel()
        return instance
    }()
}
