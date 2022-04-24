//
//  ViewController.swift
//  TipCalculator
//
//  Created by Pann Cherry on 8/25/18.
//  Copyright © 2018 Pann Cherry. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipPerPersonLabel: UILabel!
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    @IBOutlet weak var tipSegmentedControl: UISegmentedControl!
    @IBOutlet weak var numOfPerson: UILabel!
    @IBOutlet weak var numOfPersonSlider: UISlider!
    
    var currentSliderValue = Int(1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //convert currency to double
    func convertCurrencyToDouble(input: String) -> Double? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        return numberFormatter.number(from: input)?.doubleValue
    }
    
    //convert double to currency
    func convertDoubleToCurrency(amount: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        return numberFormatter.string(from: NSNumber(value: amount))!
    }
    
    //use Tap Gesture Recognition to dismiss the keyboard when tapping anywhere on the screen
    @IBAction func onTapGesture(_ sender: Any) {
        view.endEditing(true)
    }
    
    //call "view changed event" to update the numOfPerSonLabel
    @IBAction func personSlider(_ sender: Any) {
        currentSliderValue = Int(numOfPersonSlider.value)
        numOfPerson.text = ("\(currentSliderValue)")
        self.calculateTip()
    }
    
    //use Editing changed event to calculate tip using user input amount
    //inorder to get updated value according to the selected segmented control value, use "view changed" events and connect it with the calculateTip function below.
    @IBAction func calculateTip(_ sender: Any? = nil) {
        //convert the input string to double
        //if invalid input and cannot convert to double, return zero
        let bill = Double(billTextField.text!) ?? 0
        let tipPercentage = [0.10, 0.15, 0.20]
        let tip = bill * tipPercentage[tipSegmentedControl.selectedSegmentIndex]
        let total = tip + bill
        let tipPerPerson = tip/Double(currentSliderValue)
        let totalPerPerson = total/Double(currentSliderValue)
        
        //you can also use String(format: String, any) to put $ sign manually and set to two decimal. Example: tipLabel.text = String(format: "$%.2f", tip)
        tipLabel.text = convertDoubleToCurrency(amount: tip)
        totalLabel.text = convertDoubleToCurrency(amount: total)
        tipPerPersonLabel.text = convertDoubleToCurrency(amount: tipPerPerson)
        totalPerPersonLabel.text = convertDoubleToCurrency(amount: totalPerPerson)
    }
}
