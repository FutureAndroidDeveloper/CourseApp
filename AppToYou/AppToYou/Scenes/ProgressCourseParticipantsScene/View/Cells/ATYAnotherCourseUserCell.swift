//
//  ATYAnotherCourseUserCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 23.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYAnotherCourseUserCell: UITableViewCell {

    @IBOutlet weak var backWhiteView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backWhiteView.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
