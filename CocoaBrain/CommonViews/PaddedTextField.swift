//
//  PaddedTextField.swift
//  CocoaBrain
//
//  Created by Kai on 2/26/25.
//

import UIKit

class PaddedTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextField()
    }
    
    private func setupTextField() {
        theBorderColor = .brainBorder
        theBorderWidth = 1
        theCornerRadius = 8
        textColor = .brainTertiary
        font = UIFont.textStyleBody1()
        updatePlaceholder()
    }
    
    private func updatePlaceholder() {
        guard let placeholder = placeholder else { return }
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .font: UIFont.textStyleBody1(),
                .foregroundColor: UIColor.brainBorder
            ]
        )
    }
}
