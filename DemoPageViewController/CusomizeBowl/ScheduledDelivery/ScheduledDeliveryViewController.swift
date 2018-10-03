//
//  ScheduledDeliveryViewController.swift
//  DemoPageViewController
//
//  Created by Đinh Ngọc Vũ on 10/2/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import UIKit

class ScheduledDeliveryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var times = [String]()
    var previosSelectedCellIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ScheduledDeliveryTimeTableViewCell", bundle: nil), forCellReuseIdentifier: "time")
        tableView.register(UINib(nibName: "ScheduledDeliveryDayTableViewCell", bundle: nil), forCellReuseIdentifier: "day")
        times = ["6AM - 12AM", "12AM - 6PM"]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ScheduledDeliveryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return times.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "time", for: indexPath) as? ScheduledDeliveryTimeTableViewCell else {
                return UITableViewCell()
            }
            if indexPath.row == 0 {
                cell.selectedRadioButton.isSelected = true
                previosSelectedCellIndex = indexPath
            }
            cell.timeLabel.text = times[indexPath.row]
            cell.delegate = self
            cell.indexPath = indexPath
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "day", for: indexPath) as? ScheduledDeliveryDayTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Time"
        case 1:
            return "Day"
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

extension ScheduledDeliveryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ScheduledDeliveryTimeTableViewCell {
            if let index = previosSelectedCellIndex {
                if index == indexPath {
                    return
                } else {
                    if let cell = tableView.cellForRow(at: index) as? ScheduledDeliveryTimeTableViewCell {
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

extension ScheduledDeliveryViewController: ScheduledDeliveryTimeTableViewCellDelegate {
    func onSelectedButton(_ tableViewCell: ScheduledDeliveryTimeTableViewCell, buttonInCellAt indexPath: IndexPath) {
        if let index = previosSelectedCellIndex {
            if index == indexPath {
                return
            } else {
                if let cell = tableView.cellForRow(at: index) as? ScheduledDeliveryTimeTableViewCell {
                    cell.selectedRadioButton.isSelected = false
                }
            }
        }
        
        previosSelectedCellIndex = indexPath
    }
}
