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
            fadeOut(label, duration: 0)
        }
        fadeIn(defaultLabels[StorageHelper.loadDefaultPercentageIndex()], duration: 0)
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
    
    func fadeIn(target: UIView, duration: Double = 0.5) {
        UIView.animateWithDuration(duration, animations: {
            target.alpha = 1
        });
    }
    
    func fadeOut(target: UIView, duration: Double = 0.5) {
        UIView.animateWithDuration(duration, animations: {
            target.alpha = 0
        });
    }
    
    @IBAction func onSetAsDefault(sender: UIButton) {
        let index = setAsDefaultButtons.indexOf(sender) ?? 0
        let currentDefaultIndex = StorageHelper.loadDefaultPercentageIndex()
        fadeOut(defaultLabels[currentDefaultIndex])
        fadeIn(defaultLabels[index])
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
