//
//  ATYProfileSignInCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 29.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYProfileSignInCell: UITableViewCell {

    @IBOutlet weak var photoImage: UIImageView!
    var photoCallback : (() -> ())?
    @IBOutlet weak var editPhotoButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        photoImage.layer.cornerRadius = 39
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editPhotoButtonAction(_ sender: UIButton) {
        photoCallback?()
    }
}
