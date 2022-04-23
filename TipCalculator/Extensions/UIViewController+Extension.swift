//
//  UIViewController+Extension.swift
//  TipCalculator
//
//  Created by Pann Cherry on 4/21/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//
import UIKit

extension UIViewController {

    var topBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
        (navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
