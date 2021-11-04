//
//  ATYRadioButtonCreateCourse.swift
//  AppToYou
//
//  Created by Philip Bratov on 08.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYRadioButtonCreateCourse : UITableViewCell {
    var typeCell : ATYCourseType?
    var costCallback : ((Int?) -> ())?

    let labelHeader : UILabel = {
        let label = UILabel()
        label.text = "Тип курса"
        label.font = UIFont.systemFont(ofSize: 15)
        label.isHidden = true
        return label
    }()

    let labelTypeCourse : UILabel = {
        let label = UILabel()
        label.text = "Открытый"
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = R.color.textSecondaryColor()
        return label
    }()

    let radioButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.unselectedRadioButton()
        return imageView
    }()

    let payForCourse : ATYPayForCourseView = {
        let view = ATYPayForCourseView()
        view.isHidden = true
        return view
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
        contentView.addSubview(labelHeader)
        labelHeader.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }

        contentView.addSubview(radioButtonImageView)

        radioButtonImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(labelHeader)
            make.width.height.equalTo(15)
        }

        contentView.addSubview(labelTypeCourse)
        labelTypeCourse.snp.makeConstraints { (make) in
            make.leading.equalTo(radioButtonImageView.snp.trailing).offset(13.5)
            make.centerY.equalTo(radioButtonImageView)
        }

        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(radioButtonImageView.snp.bottom).offset(6)
            make.leading.equalTo(labelTypeCourse)
            make.trailing.equalToSuperview().offset(-21)

        }

        payForCourse.callbackText = { [weak self] text in
            self?.costCallback?(Int(text))
        }
        contentView.addSubview(payForCourse)
        payForCourse.snp.makeConstraints { (make) in
            make.leading.equalTo(descriptionLabel)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        radioButtonImageView.snp.makeConstraints { (make) in
            if labelHeader.isHidden {
                make.top.equalToSuperview().offset(10)
            } else {
                make.top.equalTo(labelHeader.snp.bottom).offset(20)
            }
        }

        if payForCourse.isHidden {
            payForCourse.snp.removeConstraints()
            descriptionLabel.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview().offset(-16)
            }

            payForCourse.snp.makeConstraints { (make) in
                make.leading.equalTo(descriptionLabel)
                make.trailing.equalToSuperview().offset(-20)
                make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            }
        } else {
            descriptionLabel.snp.removeConstraints()
            descriptionLabel.snp.makeConstraints { (make) in
                make.top.equalTo(radioButtonImageView.snp.bottom).offset(6)
                make.leading.equalTo(labelTypeCourse)
                make.trailing.equalToSuperview().offset(-21)
            }

            payForCourse.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview().offset(-16)
            }
        }

    }
}
