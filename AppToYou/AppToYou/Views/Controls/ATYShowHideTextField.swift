//
//  ATYShowHideTextField.swift
//  AppToYou
//
//  Created by Philip Bratov on 24.05.2021.
//  Copyright © 2021 .... All rights reserved.
//

import Foundation
import UIKit

/// Custom text field with ability of switching text displaying between hiden and open
class ATYShowHideTextField: UITextField {

    private let rightButton = UIButton(type: .custom)
    
    private var leftViewPadding: UIEdgeInsets {
        let rightInset = self.rightButton.frame.width
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: rightInset)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: leftViewPadding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: leftViewPadding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: leftViewPadding)
    }

    private func commonInit() {
        textContentType = .password
        autocorrectionType = .no
        autocapitalizationType = .none

        self.rightButton.setImage(R.image.eye() , for: .normal)
        self.rightButton.addTarget(self, action: #selector(toggleShowHide), for: .touchUpInside)
        self.rightButton.frame = CGRect(x:0, y:0, width: self.frame.width, height: self.frame.height)
        self.rightButton.contentEdgeInsets = UIEdgeInsets(top: 3, left: 6, bottom: 3, right: 6)

        rightViewMode = .always
        rightView = self.rightButton
        isSecureTextEntry = true
    }

    @objc private func toggleShowHide(button: UIButton) {
        self.toggle()
    }

    private func toggle() {
        isSecureTextEntry = !isSecureTextEntry
        if isSecureTextEntry {
            self.rightButton.setImage(R.image.eye() , for: .normal)
        } else {
            self.rightButton.setImage(R.image.eye() , for: .normal)
        }
    }
}


extension ATYShowHideTextField {
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.width - 80, y: 2, width: 90, height: 44)
    }
}
