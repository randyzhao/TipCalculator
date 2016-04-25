//
//  ViewController.swift
//  tips
//
//  Created by randy_zhao on 4/24/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let currencyFormatter = NSNumberFormatter()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        currencyFormatter.numberStyle = .CurrencyStyle
        currencyFormatter.maximumFractionDigits = 2
    }
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
    }

    @IBOutlet weak var tipControl: UISegmentedControl!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func formatedPrice(price: Double) -> String{
        return self.currencyFormatter.stringFromNumber(price) ?? ""
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        let tipPercentages = [0.18, 0.20, 0.22]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = Double(billField.text ?? "0") ?? 0
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        tipLabel.text = self.formatedPrice(tip)
        totalLabel.text = self.formatedPrice(total)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

