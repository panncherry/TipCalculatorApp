//
//  GlobalFunctions.swift
//  TipCalculator
//
//  Created by Pann Cherry on 4/25/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit

func appDelegate() -> AppDelegate {
    return (UIApplication.shared.delegate as! AppDelegate)
}

func delay(seconds: Double, closure: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        closure()
    }
}

let percentFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    formatter.numberStyle = .percent
    formatter.locale = Locale(identifier: "en-US_POSIX")
    return formatter
}()
