//
//  CustomSlider.swift
//  TipCalculator
//
//  Created by Pann Cherry on 4/22/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit

@IBDesignable
public class CustomSlider: UISlider {

    public override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var result = super.trackRect(forBounds: bounds)
        result.origin.x = 0
        result.size.height = 6
        result.size.width = bounds.size.width
        return result
    }
}
