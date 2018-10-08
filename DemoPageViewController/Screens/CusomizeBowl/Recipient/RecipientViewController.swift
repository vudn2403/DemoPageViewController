//
//  BowlViewController.swift
//  DemoPageViewController
//
//  Created by Đinh Ngọc Vũ on 10/2/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import UIKit
import DLRadioButton

class RecipientViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users = [String]()
    var previosSelectedCellIndex : IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUp() {
        tableView.register(UINib(nibName: "RecipientAddNewTableViewCell", bundle: nil), forCellReuseIdentifier: "addNew")
        tableView.register(UINib(nibName: "RecipientSavedInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "savedInfo")
        users = ["Nguyen Van A", "Nguyen Van B", "Nguyen Van C"]
        let tapViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapView(_:)))
        tapViewGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapViewGestureRecognizer)
    }
    
    @objc func onTapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func isVerify() -> Bool {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? RecipientAddNewTableViewCell else {
            return false
        }
        
        return cell.isVerifyField()
    }
}

extension RecipientViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return users.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "savedInfo", for: indexPath) as? RecipientSavedInfoTableViewCell else {
                return UITableViewCell()
            }
            if indexPath.row == 0 {
                cell.selectedRadioButton.isSelected = true
                previosSelectedCellIndex = indexPath
            }
            cell.delegate = self
            cell.indexPath = indexPath
            cell.nameLabel.text = users[indexPath.row]
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "addNew", for: indexPath) as? RecipientAddNewTableViewCell else {
                return UITableViewCell()
            }
            cell.viewController = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Saved Info"
        case 1:
            return "Add new"
        default:
            return "Header"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
}

extension RecipientViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RecipientSavedInfoTableViewCell {
            if let index = previosSelectedCellIndex {
                if index == indexPath {
                    return
                } else {
                    if let cell = tableView.cellForRow(at: index) as? RecipientSavedInfoTableViewCell {
                        cell.selectedRadioButton.isSelected = false
                    }
                }
            }
            previosSelectedCellIndex = indexPath
            cell.selectedRadioButton.isSelected = true
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
}

extension RecipientViewController: RecipientSavedInfoTableViewCellDelegate {
    func onSelectedButton(_ tableViewCell: RecipientSavedInfoTableViewCell, buttonInCellAt indexPath: IndexPath) {
        if let index = previosSelectedCellIndex {
            if index == indexPath {
                return
            } else {
                if let cell = tableView.cellForRow(at: index) as? RecipientSavedInfoTableViewCell {
                    cell.selectedRadioButton.isSelected = false
                }
            }
        }
        
        previosSelectedCellIndex = indexPath
    }
}
