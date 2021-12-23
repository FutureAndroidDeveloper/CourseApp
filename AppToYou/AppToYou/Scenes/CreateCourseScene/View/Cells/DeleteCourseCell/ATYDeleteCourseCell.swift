//
//  ATYDeleteCourseCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 22.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYDeleteCourseCell : UITableViewCell {

    let deleteImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.deleteImage()?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = R.color.iconsTintColor()
        return imageView
    }()

    let deleteLabel : UILabel = {
        let label = UILabel()
        label.text = "Удалить курс"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(deleteImageView)
        contentView.addSubview(deleteLabel)

        deleteImageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(20)
            make.height.equalTo(22)
        }

        deleteLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(deleteImageView.snp.trailing).offset(12)
            make.centerY.equalTo(deleteImageView)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
