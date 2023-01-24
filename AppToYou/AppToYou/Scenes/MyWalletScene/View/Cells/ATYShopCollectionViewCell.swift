//
//  ATYShopCollectionViewCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 04.08.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYShopCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backNewView: UIView!
    @IBOutlet weak var newLabel: UILabel!
    @IBOutlet weak var howMuchCost: UILabel!
    @IBOutlet weak var howMuchMoney: UILabel!
    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var backView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 25
        backNewView.layer.cornerRadius = 11.5
    }

    func setUp(howMuchCost: Double, howMuchMoney: Int, coinImageView: UIImage?, isHiddenNewLabel: Bool) {
        self.howMuchCost.text = String(format: "%.2f", howMuchCost) + " $"
        self.howMuchMoney.text = String(howMuchMoney) + " монет"
        self.coinImageView.image = coinImageView
        self.backNewView.isHidden = isHiddenNewLabel
        self.newLabel.isHidden = isHiddenNewLabel
    }

}
