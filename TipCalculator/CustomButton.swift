//
//  CustomButton.swift
//  TipCalculator
//
//  Created by Pann Cherry on 4/21/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit

@IBDesignable
public class CustomButton: UIButton {

    // MARK: - IBInspectable properties
    /// Applies border to the text view with the specified width
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
            layer.borderColor = borderColor.cgColor
        }
    }
    
    /// Sets the color of the border
    @IBInspectable public var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    /// Make the corners rounded with the specified radius
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    /// Sets the shadow radius
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.masksToBounds = false
            layer.shadowRadius = newValue
        }
    }

    /// Sets the shadow opacity
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.masksToBounds = false
            layer.shadowOpacity = newValue
        }
    }

    /// Sets the shadow offset
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.masksToBounds = false
            layer.shadowOffset = newValue
        }
    }

    /// Sets the shadow color
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }

    public override var isSelected: Bool {
        didSet {
            let backgroundColor: UIColor = isSelected ? .G200 : .white
            self.backgroundColor = backgroundColor

            let title = self.titleLabel?.text ?? ""
            let selectedAttributedTitle = NSAttributedString(string: "\(title)", attributes: [.foregroundColor : UIColor.white])
            self.setAttributedTitle(selectedAttributedTitle, for: .selected)

            let normalAttributedTitle = NSAttributedString(string: "\(title)", attributes: [.foregroundColor : UIColor.G300])
            self.setAttributedTitle(normalAttributedTitle, for: .normal)
        }
    }
    
    init(title: String) {
        super.init(frame: CGRect.zero)
        setTitle(title, for: .normal)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
    }

    public override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.size.width, height: CGFloat.greatestFiniteMagnitude)) ?? .zero
        let desiredButtonSize = CGSize(width: labelSize.width + 24 + titleEdgeInsets.left + titleEdgeInsets.right, height: labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom)

        return desiredButtonSize
    }
    

    private func commonInit() {
    }
}
