//
//  RecipientSavedInfoTableViewCell.swift
//  DemoPageViewController
//
//  Created by Đinh Ngọc Vũ on 10/2/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import UIKit
import DLRadioButton

protocol RecipientSavedInfoTableViewCellDelegate: NSObjectProtocol {
    func onSelectedButton(_ tableViewCell: RecipientSavedInfoTableViewCell, buttonInCellAt indexPath: IndexPath)
}

class RecipientSavedInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var selectedRadioButton: DLRadioButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var showInfoButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    weak var delegate: RecipientSavedInfoTableViewCellDelegate?
    var indexPath: IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func onSelected(_ sender: Any) {
        if let indexPath = indexPath {
            delegate?.onSelectedButton(self, buttonInCellAt: indexPath)
        }
    }
    @IBAction func onViewInfo(_ sender: UIButton) {
        sender.isHidden = true
        doneButton.isHidden = false
    }
    
    @IBAction func onDone(_ sender: UIButton) {
        sender.isHidden = true
        showInfoButton.isHidden = false
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let screen = UIScreen.main.bounds
        let width = CGFloat(1)
        let border = CALayer()
        border.frame = CGRect(x: 15, y: rect.height - width, width: screen.width - 30, height: width)
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
