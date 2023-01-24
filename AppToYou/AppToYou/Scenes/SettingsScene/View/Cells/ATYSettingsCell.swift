//
//  ATYSettingsCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 05.08.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYSettingsCell: UITableViewCell {

    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var nameSettingsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        switchButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUp(name: String, rightLabelText: String?) {
        nameSettingsLabel.text = name
        if let text = rightLabelText {
            rightLabel.isHidden = false
            switchButton.isHidden = true
            rightLabel.text = text
        } else {
            rightLabel.isHidden = true
            switchButton.isHidden = false
        }
    }
    
}
