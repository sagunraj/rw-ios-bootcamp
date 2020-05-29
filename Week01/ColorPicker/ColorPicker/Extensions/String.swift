//
//  String.swift
//  ColorPicker
//
//  Created by Sagun Raj Lage on 5/29/20.
//  Copyright © 2020 Sagun Raj Lage. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    
    var hasValue: Bool {
        return self != nil
    }
    
}
