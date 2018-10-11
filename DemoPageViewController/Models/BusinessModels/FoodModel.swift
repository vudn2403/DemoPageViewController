//
//  FoodModel.swift
//  DemoPageViewController
//
//  Created by Đinh Ngọc Vũ on 10/10/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import Foundation

class FoodModel {
    var id: String
    var name: String
    var weight: Int
    var cost: Int
    var type: String
    
    init(id: String, name: String, weight: Int, cost: Int, type: String) {
        self.id = id
        self.name = name
        self.weight = weight
        self.cost = cost
        self.type = type
    }
}
