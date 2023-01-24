//
//  ATYCardView.swift
//  AppToYou
//
//  Created by Philip Bratov on 28.07.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYCardView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var largeTitleLabel: UILabel!
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!


    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!

    var firstCallback : (() -> ())?
    var secondCallback : (() -> ())?
    var thirdCallback : (() -> ())?

    @IBAction func firstButtonAction(_ sender: UIButton) {
        firstCallback?()
    }

    @IBAction func secondButtonAction(_ sender: UIButton) {
        secondCallback?()
    }

    @IBAction func thirdButtonAction(_ sender: UIButton) {
        thirdCallback?()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("ATYCardView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

    }
}
