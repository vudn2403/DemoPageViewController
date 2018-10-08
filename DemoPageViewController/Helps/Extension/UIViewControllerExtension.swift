//
//  UIViewControllerExtension.swift
//  DemoPageViewController
//
//  Created by Đinh Ngọc Vũ on 10/8/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func alertWith(_ title: String?, _ message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Đồng ý", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
