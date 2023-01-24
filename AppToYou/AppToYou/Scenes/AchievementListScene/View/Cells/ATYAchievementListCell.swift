//
//  ATYAchievementListCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 30.07.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYAchievementListCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!

    @IBOutlet weak var achievementImageView: UIImageView!
    @IBOutlet weak var achievementName: UILabel!
    @IBOutlet weak var moneyForAchievement: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var descriptionAchievement: UILabel!
    @IBOutlet weak var diamondLabel: UILabel!
    @IBOutlet weak var succesImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 25
    }

    func setUp(image : UIImage?,
               achievementName: String?,
               descriptionAchievement: String?,
               moneyForAchievement: Int,
               progress: Double?) {
        self.achievementImageView.image = image
        self.achievementName.text = achievementName
        self.descriptionAchievement.text = descriptionAchievement
        self.moneyForAchievement.text = String(moneyForAchievement)
        self.progressView.progress = Float(progress ?? 0)
        self.succesImageView.image = R.image.backgroundOrangeImage()
        self.diamondLabel.text = "алмазов"
        self.moneyForAchievement.isHidden = false
        if progress == 1.0 {
            self.succesImageView.image = R.image.succesTaskImage()
            self.moneyForAchievement.isHidden = true
            self.diamondLabel.text = String(moneyForAchievement)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.achievementImageView.image = nil
        self.achievementName.text = nil
        self.descriptionAchievement.text = nil
        self.moneyForAchievement.text = nil
        self.progressView.progress = 0.0
        self.diamondLabel.text = nil
        self.succesImageView.image = nil
    }
    
}
