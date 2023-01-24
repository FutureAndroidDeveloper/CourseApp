//
//  ATYProgressTaskCourseUserCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 23.07.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYProgressTaskCourseUserCell: UITableViewCell {

    @IBOutlet weak var nameTaskLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var numberOfTask: UILabel!
    @IBOutlet weak var succesLabel: UILabel!
    @IBOutlet weak var failedLabel: UILabel!
    @IBOutlet weak var sanctionIcon: UIImageView!
    @IBOutlet weak var countDuration: UILabel!
    
    @IBOutlet weak var dotView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUp(nameTask: String,
               period: String,
               countDuration: String?,
               numberOfTask: Int,
               succesTasks: String,
               failedTasks: String,
               hasSanction: Bool) {
        nameTaskLabel.text = nameTask
        periodLabel.text = period
        self.countDuration.text = countDuration
        self.numberOfTask.text = String(numberOfTask) + "."
        succesLabel.text = succesTasks
        failedLabel.text = failedTasks
        sanctionIcon.isHidden = !hasSanction
        dotView.isHidden = countDuration == nil

        self.succesLabel.textColor = succesTasks == "0" ? R.color.textSecondaryColor() : R.color.titleTextColor()
        self.failedLabel.textColor = failedTasks == "0" ? R.color.textSecondaryColor() : R.color.titleTextColor()
    }
}
