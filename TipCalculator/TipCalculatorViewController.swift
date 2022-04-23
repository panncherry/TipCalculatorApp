//
//  TipCalculatorViewController.swift
//  TipCalculator
//
//  Created by Pann Cherry on 4/20/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit

class TipCalculatorViewController: UIViewController {

    @IBOutlet weak var bottomView: UIView!

//    @IBOutlet weak var tenPercentButton: CustomButton!

    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "EasyTiips"
        topViewHeightConstraint.constant = self.topBarHeight + 30

        bottomView.layer.cornerRadius = 20
        view.layoutIfNeeded()
    }

    @IBAction func tenPercentButtonHit(_ sender: Any) {

    }
}
