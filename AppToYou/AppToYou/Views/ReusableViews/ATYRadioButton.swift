//
//  ATYRadioButton.swift
//  AppToYou
//
//  Created by Philip Bratov on 31.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit


class RadioButtonController: NSObject {
    var buttonsArray: [UIButton]! {
        didSet {
            for b in buttonsArray {
                b.setImage(R.image.unselectedRadioButton(), for: .normal)
                b.setImage(R.image.selectedRadioButton(), for: .selected)
            }
        }
    }
    
    var selectedButton: UIButton?
    var defaultButton: UIButton = UIButton() {
        didSet {
            buttonArrayUpdated(buttonSelected: self.defaultButton)
        }
    }

    func buttonArrayUpdated(buttonSelected: UIButton) {
        for b in buttonsArray {
            if b == buttonSelected {
                selectedButton = b
                b.isSelected = true
            } else {
                b.isSelected = false
            }
        }
    }
}
