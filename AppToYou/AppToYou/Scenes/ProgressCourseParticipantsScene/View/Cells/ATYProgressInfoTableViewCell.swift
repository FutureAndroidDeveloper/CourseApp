//
//  ATYProgressInfoTableViewCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 23.07.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYProgressInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var countDaysOnCourse: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.image = R.image.courseParticipantImage()
        iconImageView.layer.cornerRadius = 50.5
        backgroundColor = R.color.backgroundAppColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
