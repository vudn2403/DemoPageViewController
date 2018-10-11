//
//  ProductGroupViewController.swift
//  DemoPageViewController
//
//  Created by Đinh Ngọc Vũ on 10/10/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import UIKit

class BowlProductViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var cellList = [String]()
    var orders = OrdersModel.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUp()
        createData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUp() {
        cellList = [BowlProductTitleTableViewCell.nibName(),
                        BowlProductTableViewCell.nibName()]
        cellList.forEach({
            tableView.register(UINib(nibName: $0, bundle: nil),
                               forCellReuseIdentifier: $0)
        })
    }
    
    func createData() {
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
        orders.ordersDetails.append(od1)
        orders.ordersDetails.append(od2)
        orders.ordersDetails.append(od3)
        orders.ordersDetails.append(od4)
        orders.ordersDetails.append(od5)
        tableView.reloadData()
    }
}

extension BowlProductViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : orders.ordersDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: cellList[indexPath.section],
                for: indexPath) as? BowlProductTitleTableViewCell else {
                    return UITableViewCell()
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: cellList[indexPath.section],
                for: indexPath) as? BowlProductTableViewCell else {
                    return UITableViewCell()
            }
            let ordersDetail = orders.ordersDetails[indexPath.row]
            cell.pendingData(ordersDetail: ordersDetail)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 5 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = AppColor.colorPaleGray()
        return view
    }
}

extension BowlProductViewController: UITableViewDelegate {
    
}
