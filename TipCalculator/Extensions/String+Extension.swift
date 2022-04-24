//
//  String+Extension.swift
//  TipCalculator
//
//  Created by Pann Cherry on 4/23/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit

extension String {

    /// Formats textFields text with $ symbols for valid inputs such as 0-9.
    /// Delete all leading zeros from the string.
    func currencyInputFormatting() -> String {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2

        var amountWithPrefix = self

        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")

        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))


        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }

        return formatter.string(from: number)!
    }

    /// Returns formatted number string
    var decimalNumberString: String? {
        guard let largeNumber = Double(self) else { return nil }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        let formattedNumber = numberFormatter.string(from: NSNumber(value:largeNumber))
        return formattedNumber
    }

    /// Remove characters from string
    /// Returns string
    func removeChars(preventDecimals: Bool = false) -> String {
        var input = self
        var stripCharacters = ["$", ",", "%"]

        if (preventDecimals) {
            stripCharacters.append(".")
        }

        for i in 0..<stripCharacters.count {
            input = input.replacingOccurrences(of: stripCharacters[i], with: "", options: NSString.CompareOptions.literal, range:nil)
        }

        return input
    }
}
