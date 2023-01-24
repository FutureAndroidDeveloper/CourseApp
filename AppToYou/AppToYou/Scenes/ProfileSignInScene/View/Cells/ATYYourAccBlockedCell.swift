//
//  ATYYourAccBlockedCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 03.08.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYYourAccBlockedCell: UITableViewCell {

    var paySanctionAction : (() -> ())?
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var paySanctionButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 25
        paySanctionButton.layer.cornerRadius = 22
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func paySanctionAction(_ sender: UIButton) {
        paySanctionAction?()
    }

}
