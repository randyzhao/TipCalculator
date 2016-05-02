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
        setPercentageSegs()
        if let billAmount = StorageHelper.loadBillAmountIfNotExpired() {
            billField.text = String(billAmount)
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setPercentageSegs()
        updateLabels()
        billField.becomeFirstResponder();
    }
    
    func setPercentageSegs() {
        for index in 0...2 {
            let percentage = StorageHelper.loadOrUseDefaultPercentage(index)
            PercentageSeg.setTitle("\(percentage)%", forSegmentAtIndex: index)
        }
        PercentageSeg.selectedSegmentIndex = StorageHelper.loadDefaultPercentageIndex()
    }
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func formatedPrice(price: Double) -> String{
        return self.formatAmount(price)
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        updateLabels()
        if let billAmount = Double(billField.text ?? "") {
            StorageHelper.saveBillAmountWithTimestamp(billAmount)
        }
    }
    
    func formatAmount(total: Double) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter.stringFromNumber(total) ?? ""
    }
    
    func updateLabels() {
        let tipPercentage = Double(StorageHelper.loadOrUseDefaultPercentage(tipControl.selectedSegmentIndex)) * 0.01
        
        let billAmount = Double(billField.text ?? "0") ?? 0
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        tipLabel.text = self.formatedPrice(tip)
        totalLabel.text = self.formatedPrice(total)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBOutlet weak var PercentageSeg: UISegmentedControl!
}

