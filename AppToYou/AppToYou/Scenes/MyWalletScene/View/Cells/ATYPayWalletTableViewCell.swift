//
//  ATYPayWalletTableViewCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 04.08.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYPayWalletTableViewCell: UITableViewCell {

    @IBOutlet weak var payButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        payButton.layer.cornerRadius = 22
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
