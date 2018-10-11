//
//  ProductGroupViewController.swift
//  DemoPageViewController
//
//  Created by Đinh Ngọc Vũ on 10/10/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import UIKit

enum ProductType: String {
    case protein = "Protein"
    case veggies = "Veggies"
    case sauceForSalad = "SauceForSalad"
}

class BowlProductViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var cellList = [String]()
    var orders = OrdersModel()
    var productType: ProductType?
    
    init(_ productType: ProductType) {
        self.productType = productType
        super.init(nibName: "BowlProductViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUp()
        createData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
            cell.productTypeLabel.text = self.productType?.rawValue
            cell.suggestWeightLabel.text = "120g"
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
