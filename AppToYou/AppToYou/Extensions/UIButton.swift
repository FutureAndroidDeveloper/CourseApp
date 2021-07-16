//
//  UIButton.swift
//  AppToYou
//
//  Created by Philip Bratov on 31.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYWeekDaysButton : UIButton {
    override open var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? R.color.textColorSecondary() : R.color.backgroundTextFieldsColor()
        }
    }
}

extension UIButton {
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount + 5, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
}

class ATYChainButton : UIButton {
    override open var isSelected: Bool {
        didSet {
            imageView?.tintColor = isSelected ? R.color.textColorSecondary() : R.color.backgroundTextFieldsColor()
        }
    }
}
