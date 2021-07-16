//
//  ATYShareCourseCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 21.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYShareCourseCell : UITableViewCell {
    let shareLabel : UILabel = {
        let label = UILabel()
        label.text = "Поделись курсом с друзьями.\nМеняйтесь вместе!"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 2
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let shareImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.shareCourseImage()
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(shareLabel)
        contentView.addSubview(shareImageView)

        shareLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(50)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }

        shareImageView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(shareLabel)
            make.height.width.equalTo(38)
        }
    }
}
