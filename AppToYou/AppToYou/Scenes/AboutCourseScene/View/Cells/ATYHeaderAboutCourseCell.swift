//
//  ATYHeaderAboutCourseCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 09.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYHeaderAboutCourseCell: UITableViewCell {

    let headerImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.exampleAboutCourse()
        return imageView
    }()

    let myCourseLabel : UILabel = {
        let label = UILabel()
        label.text = "мой курс"
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = R.color.textColorSecondary()
        return label
    }()

    let editButton : UIButton = {
        let button = UIButton()
        button.setImage(R.image.editButtonCourse(), for: .normal)
        return button
    }()

    let backButton : UIButton = {
        let button = UIButton()
        button.setImage(R.image.backBlurButton(), for: .normal)
        return button
    }()

    //Labels

    let durationLabel : UILabel = {
        let label = UILabel()
        label.text = "1 мес"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.sizeToFit()
        label.textColor = R.color.backgroundTextFieldsColor()
        return label
    }()

    let countOfPeopleLabel : UILabel = {
        let label = UILabel()
        label.text = "1 454"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.sizeToFit()
        label.textColor = R.color.backgroundTextFieldsColor()
        return label
    }()

    let coinLabel : UILabel = {
        let label = UILabel()
        label.text = "10"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.sizeToFit()
        label.textColor = R.color.backgroundTextFieldsColor()
        return label
    }()

    //Images

    let imageViewOcklock : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.timeOclockImage()
        return imageView
    }()

    let imageViewPeople : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.peopleImage()?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = R.color.backgroundTextFieldsColor()
        return imageView
    }()

    let imageViewCoin : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.coinImage()
        return imageView
    }()

    var callbackBackButton : (() -> Void)?
    var editButtonCallback : (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        selectionStyle = .none
        backgroundColor = R.color.backgroundAppColor()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(headerImageView)
        contentView.addSubview(myCourseLabel)
        contentView.addSubview(editButton)
        contentView.addSubview(backButton)

        myCourseLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-5)
        }

        headerImageView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(myCourseLabel.snp.top).offset(-11)
        }

        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        editButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(headerImageView.snp.bottom).offset(5)
            make.width.height.equalTo(38)
        }


        backButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        backButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(50)
            make.width.height.equalTo(40)
        }

        headerImageView.addSubview(imageViewPeople)
        headerImageView.addSubview(imageViewOcklock)
        headerImageView.addSubview(imageViewCoin)
        headerImageView.addSubview(countOfPeopleLabel)
        headerImageView.addSubview(durationLabel)
        headerImageView.addSubview(coinLabel)

        //Configure constraints blurViews

        imageViewPeople.snp.makeConstraints { (make) in
            make.top.equalTo(backButton).offset(5)
            make.trailing.equalToSuperview().offset(-16)
            make.height.width.equalTo(20)
        }

        imageViewOcklock.snp.makeConstraints { (make) in
            make.top.equalTo(imageViewPeople.snp.bottom).offset(6)
            make.trailing.equalToSuperview().offset(-16)
            make.height.width.equalTo(20)
        }

        imageViewCoin.snp.makeConstraints { (make) in
            make.top.equalTo(imageViewOcklock.snp.bottom).offset(6)
            make.trailing.equalToSuperview().offset(-16)
            make.height.width.equalTo(20)
        }

        //Configure constraints labels

        countOfPeopleLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(imageViewPeople.snp.leading).offset(-9)
            make.centerY.equalTo(imageViewPeople)
        }

        durationLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(imageViewOcklock.snp.leading).offset(-9)
            make.centerY.equalTo(imageViewOcklock)
        }

        coinLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(imageViewCoin.snp.leading).offset(-9)
            make.centerY.equalTo(imageViewCoin)
        }
    }

    @objc func buttonTapped() {
        callbackBackButton?()
    }

    @objc func editButtonTapped() {
        editButtonCallback?()
    }
}
