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

    //Blur

    let durationBlurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView()
        blurView.layer.cornerRadius = 14
        blurView.clipsToBounds = true
        return blurView
    }()

    let countOfPeopleBlurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView()
        blurView.layer.cornerRadius = 14
        blurView.clipsToBounds = true
        return blurView
    }()

    let closeOrOpenBlurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView()
        blurView.layer.cornerRadius = 14
        blurView.clipsToBounds = true
        return blurView
    }()

    //Labels

    let durationBlurLabel : UILabel = {
        let label = UILabel()
        label.text = "1 месяц"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        label.textColor = R.color.backgroundTextFieldsColor()
        return label
    }()

    let countOfPeopleBlurLabel : UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        label.textColor = R.color.backgroundTextFieldsColor()
        return label
    }()

    let closeOrOpenBlurLabel : UILabel = {
        let label = UILabel()
        label.text = "открыт"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        label.textColor = R.color.backgroundTextFieldsColor()
        return label
    }()

    //Images

    let imageViewBlurOcklock : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.timeOclockImage()
        return imageView
    }()

    let imageViewBlurPeople : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.peopleImage()?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = R.color.backgroundTextFieldsColor()
        return imageView
    }()

    let imageViewBlurOpenClose : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.openCourseImage()
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

        let blurEffect = UIBlurEffect(style: .systemThinMaterialLight)
        durationBlurView.effect = blurEffect

        let blurEffectSecond = UIBlurEffect(style: .systemThinMaterialLight)
        countOfPeopleBlurView.effect = blurEffectSecond

        let blurEffectThird = UIBlurEffect(style: .systemThinMaterialLight)
        closeOrOpenBlurView.effect = blurEffectThird

        headerImageView.addSubview(durationBlurView)
        headerImageView.addSubview(countOfPeopleBlurView)
        headerImageView.addSubview(closeOrOpenBlurView)

        durationBlurView.contentView.addSubview(durationBlurLabel)
        countOfPeopleBlurView.contentView.addSubview(countOfPeopleBlurLabel)
        closeOrOpenBlurView.contentView.addSubview(closeOrOpenBlurLabel)

        durationBlurView.contentView.addSubview(imageViewBlurOcklock)
        countOfPeopleBlurView.contentView.addSubview(imageViewBlurPeople)
        closeOrOpenBlurView.contentView.addSubview(imageViewBlurOpenClose)

        //Configure constraints imageView

        imageViewBlurOcklock.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
            make.width.height.equalTo(18)
        }

        imageViewBlurPeople.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
            make.width.height.equalTo(18)
        }

        imageViewBlurOpenClose.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
            make.width.height.equalTo(18)
        }

        //Configure constraints labels

        durationBlurLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(imageViewBlurOcklock.snp.trailing).offset(5.5)
            make.centerY.equalTo(imageViewBlurOcklock)
            make.trailing.equalToSuperview().offset(-9)
        }

        countOfPeopleBlurLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(imageViewBlurPeople.snp.trailing).offset(5.5)
            make.centerY.equalTo(imageViewBlurPeople)
            make.trailing.equalToSuperview().offset(-9)
        }

        closeOrOpenBlurLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(imageViewBlurOpenClose.snp.trailing).offset(5.5)
            make.centerY.equalTo(imageViewBlurOpenClose)
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-9)
        }

        //Configure constraints blurViews

        durationBlurView.snp.makeConstraints { (make) in
            make.top.equalTo(backButton)
            make.trailing.equalToSuperview().offset(-16)
        }

        countOfPeopleBlurView.snp.makeConstraints { (make) in
            make.top.equalTo(durationBlurView.snp.bottom).offset(6)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalTo(durationBlurView)
        }

        closeOrOpenBlurView.snp.makeConstraints { (make) in
            make.top.equalTo(countOfPeopleBlurView.snp.bottom).offset(6)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalTo(durationBlurView)
        }
    }

    @objc func buttonTapped() {
        callbackBackButton?()
    }

    @objc func editButtonTapped() {
        editButtonCallback?()
    }
}
