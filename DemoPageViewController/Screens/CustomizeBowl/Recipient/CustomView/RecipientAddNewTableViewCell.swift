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
        fullNameTextField.delegate = self
        addressTextField.delegate = self
        zipcodeTextField.delegate = self
        cityTextField.delegate = self
        cityTextField.startVisibleWithoutInteraction = false
        cityTextField.theme = .darkTheme()
        cityTextField.filterStrings(["Ha Noi", "Hai Phong", "Quang Ninh", "Thai Binh",
                                     "Ha Nam", "Da Nang", "TP Ho Chi Minh", "Can Tho"])
        cityTextField.itemSelectionHandler = { (filteredResults: [SearchTextFieldItem], _ index: Int) in
            self.cityTextField.text = filteredResults[index].title
            self.selectedCity = filteredResults[index].title
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        fullNameTextField.setIsOnFocus(false)
        addressTextField.setIsOnFocus(false)
        zipcodeTextField.setIsOnFocus(false)
        cityTextField.setIsOnFocus(false)
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
        let recipient = RecipientModel(fullNameTextField.text!, addressTextField.text!, selectedCity, zipcodeTextField.text!)
        BowlViewModel.shareInstance.recipient = recipient
        return true
    }
}

extension RecipientAddNewTableViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setIsOnFocus(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.setIsOnFocus(false)
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
