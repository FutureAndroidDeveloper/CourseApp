//
//  ATYSelectPhotoCourse.swift
//  AppToYou
//
//  Created by Philip Bratov on 07.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYSelectPhotoCourse: UITableViewCell {

    var nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Описание задачи"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    var photoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.coursePhotoExample()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    var typeImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.chooseCourseImage()
        imageView.isHidden = true
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
        contentView.addSubview(nameLabel)
        contentView.addSubview(photoImageView)


        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        photoImageView.layer.cornerRadius = 20
        photoImageView.clipsToBounds = true
        photoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(125)
            make.bottom.equalToSuperview().offset(-15)
        }

        photoImageView.addSubview(typeImageView)
        typeImageView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
            make.width.height.equalTo(38)
        }
    }
}
