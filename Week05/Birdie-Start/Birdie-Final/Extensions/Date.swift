//
//  Date.swift
//  Birdie-Final
//
//  Created by Sagun Raj Lage on 6/27/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

extension Date {
    
    func getDateString(ofFormat format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
}
