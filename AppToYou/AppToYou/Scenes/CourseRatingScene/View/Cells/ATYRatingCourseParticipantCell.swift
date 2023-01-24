//
//  ATYRatingCourseCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 05.08.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYRatingCourseParticipantCell: UITableViewCell {

    @IBOutlet weak var adminLabel: UILabel!
    @IBOutlet weak var backViewAdmin: UIView!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var courseImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        courseImage.layer.cornerRadius = 25
        backViewAdmin.layer.cornerRadius = 11.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUp(image: UIImage?, position: Int, percentage: Int, days: Int, name : String, isAdmin: Bool) {
        courseImage.image = image ?? UIImage(withLettersFromName: name)
        var positionText = ""
        switch position {
        case 1:
            positionText = "I место"
        case 2:
            positionText = "II место"
        case 3:
            positionText = "III место"
        default:
            positionText = String(position) + " " + "место"
        }

        positionLabel.textColor = position < 4 ? R.color.titleTextColor() : R.color.textSecondaryColor()
        positionLabel.text = positionText
        percentageLabel.text = String(percentage) + " " + "%"
        daysLabel.text = String(days) + " " + "дн."
        nameLabel.text = name
        backgroundColor = position % 2 == 0 ? R.color.backgroundAppColor() : R.color.backgroundTextFieldsColor()?.withAlphaComponent(0.4)
        adminLabel.isHidden = !isAdmin
        backViewAdmin.isHidden = !isAdmin
    }
}
