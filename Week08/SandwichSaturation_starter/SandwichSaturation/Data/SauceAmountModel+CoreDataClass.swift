//
//  SauceAmountModel+CoreDataClass.swift
//  SandwichSaturation
//
//  Created by Sagun Raj Lage on 7/19/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
//

import Foundation
import CoreData

@objc(SauceAmountModel)
public class SauceAmountModel: NSManagedObject {
    var sauceAmount: SauceAmount {
        get {
            guard let sauceAmountString = self.sauceAmountString,
                let amount = SauceAmount(rawValue: sauceAmountString) else { return .none }
            return amount
        }
        set {
            self.sauceAmountString = newValue.rawValue
        }
    }
}
