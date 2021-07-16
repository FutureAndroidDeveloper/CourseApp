//
//  ATYChooseCourseCategoryCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 14.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYChooseCourseCategoryCell: UITableViewCell {
    let radioImageView : UIImageView = {
        let view = UIImageView()
        view.image = R.image.unselectedRadioButton()
        return view
    }()

    let labelCourseLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(radioImageView)
        contentView.addSubview(labelCourseLabel)

        radioImageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }

        labelCourseLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(radioImageView.snp.trailing).offset(10)
            make.centerY.equalTo(radioImageView)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
