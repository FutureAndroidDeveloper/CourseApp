//
//  ATYShareCourseLinkCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 22.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYShareCourseLinkCell : UITableViewCell {

    let shareLabel : UILabel = {
        let label = UILabel()
        label.text = "Отправьте ссылку другу, и он сразу попадет по ней на ваш курс"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = R.color.titleTextColor()
        label.numberOfLines = 0
        return label
    }()

    let shareImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.shareCourseImage()
        return imageView
    }()

    let lineView : UIView = {
        let view = UIView()
        view.backgroundColor = R.color.lineViewMemberBackgroundColor()
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(shareLabel)
        contentView.addSubview(shareImage)
        contentView.addSubview(lineView)

        shareImage.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(16)
            make.width.height.equalTo(38)
        }

        shareLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.centerY.equalTo(shareImage)
            make.trailing.equalTo(shareImage.snp.leading).offset(-10)
            make.bottom.equalToSuperview().offset(-15)
        }

        lineView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
}
