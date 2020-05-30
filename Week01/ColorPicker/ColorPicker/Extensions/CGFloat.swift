//
//  CGFloat.swift
//  ColorPicker
//
//  Created by Sagun Raj Lage on 5/29/20.
//  Copyright © 2020 Sagun Raj Lage. All rights reserved.
//

import UIKit

extension CGFloat {
    
    var toInt: Int {
        return Int(self)
    }
    
    var toRGBValue: CGFloat {
        return self / 255.0
    }
    
    var toHueValue: CGFloat {
        return self / 360
    }
    
    var toSaturationBrightnessValue: CGFloat {
        return self / 100
    }
    
}
