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
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var splitView: UIView!
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
    let hapticManager = HapticManager(feedbackTypes: [.selection, .impactMedium])


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

    // MARK: - Actions
    /// Calculates ten percent tip
    @IBAction func tenPercentButtonHit(_ sender: Any) {
        selectedTipPercent = 0.10
        hapticManager.playMediumImpact()
        updateButtonState(selectedButton: tenPercentButton)
    }

    /// Calculates fifteen percent tip
    @IBAction func fifteenPercentButtonHit(_ sender: Any) {
        selectedTipPercent = 0.15
        hapticManager.playMediumImpact()
        updateButtonState(selectedButton: fifteenPercentButton)
    }

    /// Calculates twenty percent tip
    @IBAction func twentyPercentButtonHit(_ sender: Any) {
        selectedTipPercent = 0.20
        hapticManager.playMediumImpact()
        updateButtonState(selectedButton: twentyPercentButton)
    }

    /// Calculates twenty five percent tip
    @IBAction func twentyFivePercentButtonHit(_ sender: Any) {
        selectedTipPercent = 0.25
        hapticManager.playMediumImpact()
        updateButtonState(selectedButton: twentyFivePercentButton)
    }

    /// Calculates tip with custom tip percent
    @IBAction func customTipButtonHit(_ sender: Any) {
        hapticManager.playMediumImpact()

        guard let text = textField.text, !text.isEmpty else {
            let alert = UIAlertController(title: "", message: "Please enter total bill.", preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(submitAction)
            present(alert, animated: true)
            return
        }

        updateButtonState(selectedButton: customTipButton)
        promptCustomTipView()
    }

    /// Calculates tip and updates lables as the slider value changes
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        hapticManager.playSelectionFeedback()

        let value = Int(sender.value)
        currentSliderValue = Double(value)
        numberOfPersonLabel.text = "\(Int(currentSliderValue))"
        calculateTip()
    }

    /// Dismisses the keyboard upon tapping outside of textField
    @IBAction func viewDidTapped(_ sender: Any) {
        view.endEditing(true)
    }

    // MARK: - Helper Functions
    /// Calculates tip
    private func calculateTip() {
        guard let text = textField.text, !(text.isEmpty) else { return }

        view.endEditing(true)

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

    /// Prompts custom UIAlertViewController with textField to allow user to input custom percentage
    private func promptCustomTipView() {
        let alertVC = CustomUIAlertViewController(title: "\nCustom Tip", message: "\nEnter custom tip percentage.\n", preferredStyle: .alert)
        alertVC.delegate = self
        present(alertVC, animated: true)
    }

    /// Updates button states
    private func updateButtonState(selectedButton: CustomButton) {
        updateCustomTipButtonTitle(title: "Custom Tip")

        let buttonArray = [tenPercentButton, fifteenPercentButton, twentyPercentButton, twentyFivePercentButton, customTipButton]
        for button in buttonArray {
            button?.isSelected = (button != selectedButton) ? false : true
        }
        calculateTip()
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


// MARK: - CustomTip Delegate
extension TipCalculatorViewController: CustomTipDelegate {

    /// Calculates tips with the percentage user entered
    func calculateCustomTip(percent: Double) {
        guard percent > 0 else {
            selectedTipPercent = 0.20
            updateButtonState(selectedButton: twentyPercentButton)
            return
        }
        selectedTipPercent = percent/100
        updateCustomTipButtonTitle(title: percent.commasWithPercentFraction())
        calculateTip()
    }

    /// Updates custom tip button title
    func updateCustomTipButtonTitle(title: String) {
        let attributedTitle = NSAttributedString(string: title, attributes: [.foregroundColor : UIColor.white])
        customTipButton.setAttributedTitle(attributedTitle, for: .normal)
        customTipButton.setAttributedTitle(attributedTitle, for: .selected)
    }
}
