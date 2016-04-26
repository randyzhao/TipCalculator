//
//  SettingsViewController.swift
//  tips
//
//  Created by randy_zhao on 4/24/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        for label in defaultLabels {
            label.hidden = true
        }
        defaultLabels[StorageHelper.loadDefaultPercentageIndex()].hidden = false
        loadOrSetPercentage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadOrSetPercentage() {
        for index in 0...2 {
            let percentage = StorageHelper.loadOrUseDefaultPercentage(index)
            StorageHelper.savePercentage(index, percentage: percentage)
            percentageTextFields[index].text = String(percentage)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  
    @IBAction func onSetAsDefault(sender: UIButton) {
        let index = setAsDefaultButtons.indexOf(sender) ?? 0
        for label in defaultLabels {
            label.hidden = true
        }
        defaultLabels[index].hidden = false
        StorageHelper.saveDefaultPercentageIndex(index)
    }
    @IBAction func onPercentageTextFieldEditingChanged(sender: UITextField) {
        let index = percentageTextFields.indexOf(sender) ?? 0
        StorageHelper.savePercentage(index, percentage: Int(sender.text ?? "0") ?? 0)
    }
    
    @IBOutlet var setAsDefaultButtons: [UIButton]!
    
    @IBOutlet var defaultLabels: [UILabel]!
    
    @IBOutlet var percentageTextFields: [UITextField]!
}
