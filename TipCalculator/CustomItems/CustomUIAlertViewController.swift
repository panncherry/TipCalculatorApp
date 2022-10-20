//
//  CustomUIAlertViewController.swift
//  TipCalculator
//
//  Created by Pann Cherry on 4/26/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit

protocol CustomTipDelegate: AnyObject {
    func calculateCustomTip(percent: Double)
}

class CustomUIAlertViewController: UIAlertController {

    weak var delegate: CustomTipDelegate?

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        /// Sets tint color
        view.tintColor = .G300

        /// Sets background color and corner radius
//        if let backgroundView = view.subviews.last?.subviews.last {
//            backgroundView.layer.cornerRadius = 20.0
//            backgroundView.backgroundColor = UIColor.G100
//        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        /// Sets custom font and color of title
        if let title = title {
            var titleMutableString = NSMutableAttributedString()
            titleMutableString = NSMutableAttributedString(string: title as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Hiragino Mincho Pro W3", size: 24.0)!])
           // titleMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemGreen, range: NSRange(location:0,length: title.count))
            self.setValue(titleMutableString, forKey: "attributedTitle")
        }

        /// Sets custom font and color of message
        if let message = message {
            var messageMutableString = NSMutableAttributedString()
            messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Hiragino Mincho Pro W3", size: 18.0)!])
          //  messageMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemGreen, range: NSRange(location:0,length: message.count))
            self.setValue(messageMutableString, forKey: "attributedMessage")
        }

        /// Adds textFeild
        addTextField()
        addTextFieldActions()
        if let textField = textFields?[0] {
            textField.textColor = .G300
            textField.height(constant: 45)
            textField.textAlignment = .center
            textField.keyboardType = .decimalPad
            textField.placeholder = "0.0%"
            textField.font = UIFont(name: "Playball", size: 40) ?? UIFont.systemFont(ofSize: 40, weight: .semibold)
        }

        let submitAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            if let customTipPercent = textFields?[0].text?.removeChars() {
                self.delegate?.calculateCustomTip(percent: Double(customTipPercent) ?? 0)
            }
        }

        addAction(submitAction)
    }
}


extension CustomUIAlertViewController: UITextFieldDelegate {

    func addTextFieldActions() {
        guard let textField = textFields?[0] else { return }
        textField.delegate = self
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let oldText = textField.text else { return false }

        if string.isEmpty { // this means that backspace is pressed

            if let digits = textField.text?.digits {

                /// Deletes one digit every time backspace is pressed
                let newDigits = Double(digits.dropLast()) ?? 0

                /// Appedns new number
                textField.text = percentFormatter.string(for: newDigits / 10000)
            }

        } else // something has been entered
        if let newNumber = Double((oldText as NSString).replacingCharacters(in: range, with: string).digits) {
            textField.text = percentFormatter.string(for: newNumber / 10000)
        }
        return false
    }
}
