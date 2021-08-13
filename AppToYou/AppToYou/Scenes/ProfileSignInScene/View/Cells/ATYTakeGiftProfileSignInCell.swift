//
//  ATYTakeGiftProfileSignInCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 03.08.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYTakeGiftProfileSignInCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var takeGiftButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 25
        takeGiftButton.layer.cornerRadius = 22
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
