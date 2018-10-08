//
//  RecipientAddNewTableViewCell.swift
//  DemoPageViewController
//
//  Created by Đinh Ngọc Vũ on 10/2/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import UIKit

class RecipientAddNewTableViewCell: UITableViewCell {
    @IBOutlet weak var fullNameTextField: SearchTextField!
    @IBOutlet weak var addressTextField: SearchTextField!
    @IBOutlet weak var zipcodeTextField: SearchTextField!
    @IBOutlet weak var cityTextField: SearchTextField!
    
    var viewController: UIViewController?
    var selectedCity = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        fullNameTextField.layer.cornerRadius = 4
        fullNameTextField.layer.borderWidth = 1.0
        fullNameTextField.layer.borderColor = AppColor.colorBorderBlack().cgColor
        fullNameTextField.delegate = self
        addressTextField.layer.borderWidth = 1.0
        addressTextField.layer.borderColor = AppColor.colorBorderBlack().cgColor
        addressTextField.delegate = self
        zipcodeTextField.layer.borderWidth = 1.0
        zipcodeTextField.layer.borderColor = AppColor.colorBorderBlack().cgColor
        zipcodeTextField.delegate = self
        cityTextField.layer.borderWidth = 1.0
        cityTextField.layer.borderColor = AppColor.colorBorderBlack().cgColor
        cityTextField.delegate = self
        cityTextField.startVisibleWithoutInteraction = false
        cityTextField.theme = .darkTheme()
        cityTextField.filterStrings(["Ha Noi", "Hai Phong", "Quang Ninh", "Thai Binh",
                                     "Ha Noi", "Hai Phong", "Quang Ninh", "Thai Binh"])
        cityTextField.itemSelectionHandler = { (filteredResults: [SearchTextFieldItem], _ index: Int) in
            self.cityTextField.text = filteredResults[index].title
            self.selectedCity = filteredResults[index].title
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func isVerifyField() -> Bool {
        guard let vc = viewController else {
            return false
        }
        
        if fullNameTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
            vc.alertWith("Lỗi", "Vui lòng nhập tên")
            return false
        }
        
        if addressTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
            vc.alertWith("Lỗi", "Vui lòng nhập địa chỉ")
            return false
        }
        
        if zipcodeTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
            vc.alertWith("Lỗi", "Vui lòng nhập mã vùng")
            return false
        }
        
        if cityTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == ""
            || cityTextField.text != selectedCity {
            vc.alertWith("Lỗi", "Vui lòng nhập thành phố")
            return false
        }
        
        return true
    }
}

extension RecipientAddNewTableViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = AppColor.colorBorderRustyOrange().cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = AppColor.colorBorderBlack().cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case fullNameTextField:
            addressTextField.becomeFirstResponder()
            break
        case addressTextField:
            zipcodeTextField.becomeFirstResponder()
            break
        case zipcodeTextField:
            cityTextField.becomeFirstResponder()
            break
        case cityTextField:
            cityTextField.resignFirstResponder()
            break
        default:
            break
        }
        return false
    }
}
