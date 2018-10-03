//
//  RecipientAddNewTableViewCell.swift
//  DemoPageViewController
//
//  Created by Đinh Ngọc Vũ on 10/2/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import UIKit

class RecipientAddNewTableViewCell: UITableViewCell {
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        fullNameTextField.delegate = self
        addressTextField.delegate = self
        zipcodeTextField.delegate = self
        cityTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

extension RecipientAddNewTableViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //textField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case fullNameTextField:
            //fullNameTextField.resignFirstResponder()
            addressTextField.becomeFirstResponder()
            break
        case addressTextField:
            //addressTextField.resignFirstResponder()
            zipcodeTextField.becomeFirstResponder()
            break
        case zipcodeTextField:
            //zipcodeTextField.resignFirstResponder()
            cityTextField.becomeFirstResponder()
            break
        case cityTextField:
            cityTextField.resignFirstResponder()
            break
        default:
            break
        }
        return true
    }
}
