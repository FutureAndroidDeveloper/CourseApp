//
//  ATYCheckBox.swift
//  AppToYou
//
//  Created by Philip Bratov on 08.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

public class ATYCheckBox: UIButton {

    private let selectedCheckBox = R.image.cb_checkBoxSelected()
    private let unselectedCheckBox = R.image.cb_checkBoxUnselected()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialSetUp()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialSetUp()
    }

    public override var isHighlighted: Bool {
        didSet {
            if self.isSelected {
                self.setImage(self.selectedCheckBox, for: .highlighted)
                self.backgroundColor = R.color.textColorSecondary()
            } else {
                self.setImage(self.unselectedCheckBox, for: .highlighted)
                self.backgroundColor = R.color.backgroundAppColor()

            }
        }
    }

    private func initialSetUp() {
        self.layer.cornerRadius = 3
        self.backgroundColor = R.color.backgroundAppColor()
        self.setImage(self.unselectedCheckBox, for: .normal)
        self.setImage(self.selectedCheckBox, for: .selected)
        self.imageView?.contentMode = .scaleAspectFit
        self.addTarget(self, action: #selector(self.onTap), for: .touchUpInside)
    }

    @objc private func onTap() {
        self.isSelected.toggle()
    }
}
