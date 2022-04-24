//
//  Double+Extension.swift
//  TipCalculator
//
//  Created by Pann Cherry on 4/23/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit

extension Double {

    //convert double to currency
    func convertDoubleToCurrency() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "en_US")

        guard let currenyString = numberFormatter.string(from: NSNumber(value: self)) else {
            return nil
        }

        return currenyString
    }

    func commasNoDecimals(isCurrency: Bool) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US")
        numberFormatter.numberStyle = isCurrency ? .currency : .decimal
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter.string(from: NSNumber(value:self))!
    }

}
