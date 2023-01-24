//
//  ATYHistoryPayTableViewCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 04.08.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYHistoryPayTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var coinOrDiamondImageView: UIImageView!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var achievementLabel: UILabel!
    @IBOutlet weak var dateNameLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 15
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        dateNameLabel.text = nil
        achievementLabel.text = nil
        costLabel.text = nil
        self.coinOrDiamondImageView.image = R.image.coinImage()
        self.arrowImageView.image = nil
    }
    
    func setUp(dateName: String, achievementName: String, cost: Int, coinOrDiamond: CurrencyMoney) {
        dateNameLabel.text = dateName
        achievementLabel.text = achievementName
        costLabel.text = cost > 0 ? "+" + String(cost) : String(cost)
        switch coinOrDiamond {
        case .coin:
            self.coinOrDiamondImageView.image = R.image.coinImage()
        case .diamond:
            self.coinOrDiamondImageView.image = R.image.diamondImage()
        }

        self.arrowImageView.image = cost < 0 ? R.image.downRedArrow() : R.image.upGreenArrow()
    }
}
