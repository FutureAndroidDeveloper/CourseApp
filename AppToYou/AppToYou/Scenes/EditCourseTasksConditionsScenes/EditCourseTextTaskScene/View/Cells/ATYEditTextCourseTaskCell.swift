//
//  ATYEditTextCourseTaskCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 20.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYEditTextCourseTaskCell : UITableViewCell {

    let nameTaskLabel : UILabel = {
        let label = UILabel()
        label.text = "Хорошее за день"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()

    let executionFrequencyLabel : UILabel = {
        let label = UILabel()
        label.text = "Каждый день"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = R.color.textSecondaryColor()
        return label
    }()

    let textImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.textEditImage()
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(nameTaskLabel)
        contentView.addSubview(executionFrequencyLabel)
        contentView.addSubview(textImageView)

        textImageView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(15)
            make.width.height.equalTo(30)
        }

        nameTaskLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalTo(textImageView.snp.top)
            make.trailing.equalTo(textImageView.snp.leading).offset(-10)
        }

        executionFrequencyLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(nameTaskLabel.snp.bottom).offset(6)
            make.trailing.equalTo(textImageView.snp.leading).offset(-10)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}

