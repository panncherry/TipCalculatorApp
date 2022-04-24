//
//  UITextFields+Extension.swift
//  TipCalculator
//
//  Created by Pann Cherry on 4/21/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit

extension UITextField {
    
    /// Add underline
    func addUnderLine() {
        let bottomLine = CALayer()
        bottomLine.backgroundColor = #colorLiteral(red: 0.6705882353, green: 0.7411764706, blue: 0.5764705882, alpha: 1)
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1)
        
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
    }
    
    /// Check max length
    func checkMaxLength(_ maxLength: Int) {
        guard let text = self.text, !text.isEmpty else {
            return
        }
        
        if (text.count > maxLength) {
            self.deleteBackward()
        }
    }
    
}
