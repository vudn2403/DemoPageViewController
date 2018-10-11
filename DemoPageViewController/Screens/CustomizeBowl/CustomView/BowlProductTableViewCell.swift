//
//  CustomizedBowlProductTableViewCell.swift
//  DemoPageViewController
//
//  Created by Đinh Ngọc Vũ on 10/10/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import UIKit

class BowlProductTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    var ordersDetail: OrdersDetailModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func pendingData(ordersDetail: OrdersDetailModel) {
        nameLabel.text = ordersDetail.foodModel.name
        weightLabel.text = "\(ordersDetail.foodModel.weight) g"
        costLabel.text = "\(ordersDetail.foodModel.cost / 100) $"
        amountTextField.text = "\(ordersDetail.amount)"
        minusButton.isHidden = ordersDetail.amount == 0 ? true : false
        self.ordersDetail = ordersDetail
    }
    
    @IBAction func onPlus(_ sender: UIButton) {
        guard let ordersDetail = ordersDetail else {
            return
        }
        
        ordersDetail.amount += 1
        minusButton.isHidden = ordersDetail.amount == 0 ? true : false
        amountTextField.text = "\(ordersDetail.amount)"
    }
    
    @IBAction func onMinus(_ sender: UIButton) {
        guard let ordersDetail = ordersDetail else {
            return
        }
        if ordersDetail.amount >= 1 {
            ordersDetail.amount -= 1
            amountTextField.text = "\(ordersDetail.amount)"
            minusButton.isHidden = ordersDetail.amount == 0 ? true : false
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let screen = UIScreen.main.bounds
        let width = CGFloat(3)
        let border = CALayer()
        border.frame = CGRect(x: 0, y: rect.height - width, width: screen.width, height: width)
        border.borderWidth = width
        border.borderColor = AppColor.colorPaleGray().cgColor
        
        guard let arr = layer.sublayers else {
            return
        }
        
        // hack but worked
        if arr.count <= 2 {
            layer.addSublayer(border)
            clipsToBounds = true
        } else {
            layer.replaceSublayer(arr.last!, with: border)
        }
    }
}
