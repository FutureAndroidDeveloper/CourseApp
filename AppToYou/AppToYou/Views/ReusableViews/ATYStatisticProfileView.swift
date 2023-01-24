//
//  ATYStatisticProfileView.swift
//  AppToYou
//
//  Created by Philip Bratov on 28.07.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYStatisticProfileView: UIView {

    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("ATYStatisticProfileView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

    }
}
