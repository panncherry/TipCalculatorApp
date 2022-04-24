//
//  TipCalculatorViewController.swift
//  TipCalculator
//
//  Created by Pann Cherry on 4/20/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit

/// Design inspiration from 'https://dribbble.com/shots/6398522-Daily-UI-004-Calculator'

class TipCalculatorViewController: UIViewController {

    /// IBOutlets
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var textField: CustomTextField!
    @IBOutlet weak var tenPercentButton: CustomButton!
    @IBOutlet weak var fifteenPercentButton: CustomButton!
    @IBOutlet weak var twentyPercentButton: CustomButton!
    @IBOutlet weak var twentyFivePercentButton: CustomButton!
    @IBOutlet weak var customTipButton: CustomButton!
    @IBOutlet weak var slider: CustomSlider!
    @IBOutlet weak var numberOfPersonLabel: UILabel!
    @IBOutlet weak var totalTipLabel: UILabel!
    @IBOutlet weak var totalBillLabel: UILabel!
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    @IBOutlet weak var tipPerPersonLabel: UILabel!
    @IBOutlet weak var billPerPersonLabel: UILabel!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!


    /// Properties
    var currentSliderValue: Double = 2.0
    var selectedTipPercent: Double = 0.20


    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        twentyPercentButton.isSelected = true
        calculateTip()

        navigationItem.title = "EasyTiips"
        topViewHeightConstraint.constant = self.topBarHeight + 30

        addTextFieldActions()
        view.layoutIfNeeded()
    }

    private func updateButtonState(selectedButton: CustomButton) {
       let buttonArray = [tenPercentButton, fifteenPercentButton, twentyPercentButton, twentyFivePercentButton, customTipButton]
        for button in buttonArray {
            button?.isSelected = (button != selectedButton) ? false : true
        }
        calculateTip()
    }

    // MARK: - Actions
    @IBAction func tenPercentButtonHit(_ sender: Any) {
        selectedTipPercent = 0.10
        updateButtonState(selectedButton: tenPercentButton)
    }

    @IBAction func fifteenPercentButtonHit(_ sender: Any) {
        selectedTipPercent = 0.15
        updateButtonState(selectedButton: fifteenPercentButton)
    }

    @IBAction func twentyPercentButtonHit(_ sender: Any) {
        selectedTipPercent = 0.20
        updateButtonState(selectedButton: twentyPercentButton)
    }

    @IBAction func twentyFivePercentButtonHit(_ sender: Any) {
        selectedTipPercent = 0.25
        updateButtonState(selectedButton: twentyFivePercentButton)
    }

    @IBAction func customTipButtonHit(_ sender: Any) {
        selectedTipPercent = 0.18
        updateButtonState(selectedButton: customTipButton)
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        currentSliderValue = Double(value)
        numberOfPersonLabel.text = "\(Int(currentSliderValue))"
        calculateTip()
    }

    @IBAction func viewDidTapped(_ sender: Any) {
        view.endEditing(true)
    }

    /// Calculates tip
    private func calculateTip() {
        guard let text = textField.text, !(text.isEmpty) else { return }

        let billEntered = self.getInputAmount()

        /// Calculates tip
        let tipTotal = billEntered * selectedTipPercent

        /// Calculates total bill
        let billTotal = billEntered + tipTotal

        /// Calculates tip per person
        let tipPerPerson = tipTotal/currentSliderValue

        /// Calculates bill per person
        let billPerPerson = billEntered/currentSliderValue

        /// Calculates total per person
        let totalPerPerson = billPerPerson + tipPerPerson

        /// Updates labels text
        totalTipLabel.text = tipTotal.convertDoubleToCurrency() ?? "$0.00"
        totalBillLabel.text = billTotal.convertDoubleToCurrency() ?? "$0.00"
        tipPerPersonLabel.text = tipPerPerson.convertDoubleToCurrency() ?? "$0.00"
        billPerPersonLabel.text = billPerPerson.convertDoubleToCurrency() ?? "$0.00"
        totalPerPersonLabel.text = totalPerPerson.convertDoubleToCurrency() ?? "$0.00"
    }

    func getInputAmount() -> Double {
        var amount: Double = 0
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency

        if let number = formatter.number(from: textField.text ?? "0") {
            amount = number.doubleValue
        }

        guard let text = textField.text else {
            return amount
        }

        if let inputAmount = formatter.number(from: text) {
            amount = inputAmount.doubleValue
        }

        return amount
    }

}

// MARK: - UITextField Delegate
extension TipCalculatorViewController: UITextFieldDelegate {

    func addTextFieldActions() {
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
            textField.checkMaxLength(11)
        }
    }

    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        guard let _ = textField.text else {
            return
        }

        calculateTip()
    }

    @objc func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.textFieldDidEndEditing), object: textField)
        self.perform(#selector(self.textFieldDidEndEditing), with: textField, afterDelay: 1.0)
        return true
    }
}

extension UITextField {


    
}


