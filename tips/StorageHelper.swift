//
//  StorageHelper.swift
//  tips
//
//  Created by randy_zhao on 4/25/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import Foundation

struct StorageHelper {
    static let defaults = NSUserDefaults.standardUserDefaults()
    static let initPercentages = [18, 20, 22]
    
    static func saveDefaultPercentageIndex(index: Int) {
        defaults.setInteger(index, forKey: "default_percentage_index")
        defaults.synchronize()
    }
    
    static func loadDefaultPercentageIndex() -> Int {
        if let indexObject = defaults.objectForKey("default_percentage_index") {
            return Int(indexObject as! NSNumber)
        } else {
            return 0
        }
    }
    
    static func loadOrUseDefaultPercentage(index: Int) -> Int {
        var percentage = 0
        if let percentageObject = defaults.objectForKey("percentage\(index)") {
            percentage = Int(percentageObject as! NSNumber)
        } else {
            percentage = initPercentages[index]
        }
        return percentage
    }
    
    static func savePercentage(index: Int, percentage: Int) {
        defaults.setInteger(percentage, forKey: "percentage\(index)")
        defaults.synchronize()
    }
    
    static func saveBillAmountWithTimestamp(billAmount: Double) {
        defaults.setDouble(billAmount, forKey: "bill_amount")
        defaults.setObject(NSDate().timeIntervalSince1970, forKey: "bill_amount_timestamp")
    }
    
    static func loadBillAmountIfNotExpired() -> Double? {
        if let timestamp = defaults.objectForKey("bill_amount_timestamp") {
            let savedTime = timestamp as! NSTimeInterval
            let now = NSDate().timeIntervalSince1970
            if now - savedTime >= 0 && now - savedTime <= 600000 { // 10 min * 60s/min * 1000ms/s
                return defaults.doubleForKey("bill_amount")
            }
        }
        return nil
    }
}