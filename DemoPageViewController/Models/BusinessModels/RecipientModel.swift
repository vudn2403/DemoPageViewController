//
//  RecipientModel.swift
//  DemoPageViewController
//
//  Created by Đinh Ngọc Vũ on 10/8/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import Foundation

class RecipientModel {
    var name: String
    var address: String
    var city: String
    var zipCode: String
    
    init(_ name: String, _ address: String, _ city: String, _ zipCode: String) {
        self.name = name
        self.address = address
        self.city = city
        self.zipCode = zipCode
    }
}
