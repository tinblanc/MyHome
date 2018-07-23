//
//  ValidationTextView.swift
//  MyHome
//
//  Created by Tin Blanc on 7/11/18.
//  Copyright © 2018 Tin Blanc. All rights reserved.
//

import UIKit
import AMPopTip

final class ValidationTextField: SkyFloatingLabelTextField {
    
    private var button: UIButton?
    private let popTip = PopTip()
    
    var bubbleColor = UIColor(hex: 0xE25141)
    var leftPadding: CGFloat = 16
    var rightPadding: CGFloat = 16
    
    private var _validationString = ""
    private let buttonWidth: CGFloat = 40
    
    var validationResult: Binder<ValidationResult> {
        return Binder(self) { textField, result in
            let errorString: String
            if case let ValidationResult.invalid(errors) = result {
                //                errorString = errors.map { String(describing: $0) }.joined(separator: "\n")
                errorString = errors.first.flatMap { String(describing: $0) } ?? ""
            } else {
                errorString = ""
            }
            textField._validationString = errorString
            guard let button = self.button else { return }
            if errorString.isEmpty {
                button.isHidden = true
                textField.popTip.hide()
                var frame = button.frame
                frame.size.width = textField.rightPadding
                button.frame = frame
            } else {
                button.isHidden = false
                var frame = button.frame
                frame.size.width = textField.buttonWidth
                button.frame = frame
            }
        }
    }
    
    func setup() {
        let overcastBlueColor = UIColor.blueA
        
        self.do {
            $0.textColor = UIColor.black //UIColor.darkGray
            $0.lineColor = UIColor.lightGray
            
            $0.tintColor = overcastBlueColor
            $0.selectedTitleColor = overcastBlueColor
            $0.selectedLineColor = overcastBlueColor
            
            $0.lineHeight = 0.5 // bottom line height in points
            $0.selectedLineHeight = 1.0
        }
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: buttonWidth, height: self.frame.height)).with {
            $0.setImage(#imageLiteral(resourceName: "input_error"), for: .normal)
            $0.addTarget(self, action: #selector(showPopTip), for: .touchUpInside)
            $0.isHidden = true
        }
        self.rightView = button
        self.rightViewMode = .always
        self.button = button
        
        //self.setLeftPaddingPoints(leftPadding)
    }
    
    @objc func showPopTip() {
        guard let superView = self.superview, let button = self.button else { return }
        let direction = PopTipDirection.left
        popTip.do {
            $0.bubbleColor = bubbleColor
            $0.actionAnimation = .none
            $0.offset = -20
        }
        popTip.bubbleColor = bubbleColor
        popTip.actionAnimation = .none
        popTip.offset = -5
        popTip.font = UIFont.systemFont(ofSize: 13)
        
        let buttonFrame = CGRect(x: button.frame.origin.x + self.frame.origin.x,
                                 y: button.frame.origin.y + self.frame.origin.y,
                                 width: button.frame.width,
                                 height: button.frame.height)
        
        popTip.show(text: _validationString,
                    direction: direction,
                    maxWidth: self.frame.width - buttonWidth - 5,
                    in: superView,
                    from: buttonFrame)
    }
}
