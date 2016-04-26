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
}