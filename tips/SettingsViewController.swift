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
        defaultLabels[0].hidden = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    }
    
    @IBOutlet var setAsDefaultButtons: [UIButton]!
    
    @IBOutlet var defaultLabels: [UILabel]!
    
}
