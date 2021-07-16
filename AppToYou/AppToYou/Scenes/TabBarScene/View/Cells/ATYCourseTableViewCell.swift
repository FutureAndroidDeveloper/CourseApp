//
//  ATYCourseTableViewCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 04.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYCourseTableViewCell : UITableViewCell {

    let backgroundViewCell : UIView = {
        let view = UIView()
        view.backgroundColor = R.color.backgroundTextFieldsColor()
        return view
    }()

    let imageViewCourse : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    let typeOfCourseLabel : UILabel = {
        let label = UILabel()
        label.text = "мой курс"
        label.font = UIFont.systemFont(ofSize: 14,weight: .medium)
        label.textColor = R.color.textColorSecondary()
        return label
    }()

    let nameCourseLabel : UILabel = {
        let label = UILabel()
        label.text = "Ментальное здоровье"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    let descriptionCourseLabel : UILabel = {
        let label = UILabel()
        label.text = "Существует тесная взаимосвязь между психикой и физическим состоянием человека. Чувство тревоги, постоянные тест текст длина тест текст"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = R.color.textSecondaryColor()
        label.numberOfLines = 3
        return label
    }()

    //MARK:- Images views for bottom view

    let peopleImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.peopleImage()
        return imageView
    }()

    let likesImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.likesView()
        return imageView
    }()

    let chatImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.chatImage()
        return imageView
    }()

    //MARK:- Labels for bottom view

    let countPeopleLabel : UILabel = {
        let label = UILabel()
        label.text = "1 428"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let countLikesLabel : UILabel = {
        let label = UILabel()
        label.text = "1222"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let countChatMessagesLabel : UILabel = {
        let label = UILabel()
        label.text = "+225"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    //MARK:- Stack views

    let peopleStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()

    let shareStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()

    let likesStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()

    let chatStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()

    let allStackViews : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()

    let bottomRightImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.shareImage()
        return imageView
    }()

    let bottomRightLabel : UILabel = {
        let label = UILabel()
        label.text = "Подробнее"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14,weight: .medium)
        label.sizeToFit()
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let blurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView()
        blurView.layer.cornerRadius = 13
        blurView.clipsToBounds = true
        return blurView
    }()

    let countTaskLabel : UILabel = {
        let label = UILabel()
        label.text = "10 задач"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        label.textColor = R.color.backgroundTextFieldsColor()
        return label
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
        contentView.addSubview(backgroundViewCell)
        backgroundViewCell.layer.cornerRadius = 25
        backgroundViewCell.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-10)
        }

        backgroundViewCell.addSubview(imageViewCourse)
        imageViewCourse.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(backgroundViewCell.snp.height).multipliedBy(0.38)
        }

        imageViewCourse.layer.cornerRadius = 15
        imageViewCourse.clipsToBounds = true
        imageViewCourse.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        backgroundViewCell.addSubview(typeOfCourseLabel)

        typeOfCourseLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageViewCourse.snp.bottom).offset(16)
            make.trailing.equalToSuperview().offset(-24)
            make.leading.equalToSuperview().offset(24)
        }

        backgroundViewCell.addSubview(nameCourseLabel)

        nameCourseLabel.snp.makeConstraints { (make) in
            make.top.equalTo(typeOfCourseLabel.snp.bottom).offset(7)
            make.trailing.equalToSuperview().offset(-24)
            make.leading.equalToSuperview().offset(24)
        }

        backgroundViewCell.addSubview(descriptionCourseLabel)

        descriptionCourseLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameCourseLabel.snp.bottom).offset(15)
            make.trailing.equalToSuperview().offset(-24)
            make.leading.equalToSuperview().offset(24)
        }

        //Configure stackView

        backgroundViewCell.addSubview(allStackViews)
        allStackViews.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-28)
            make.trailing.equalToSuperview().offset(-24)
        }

        peopleImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(20)
        }

        countPeopleLabel.snp.makeConstraints { (make) in
            make.width.equalTo(40)
        }

        peopleStackView.addArrangedSubview(peopleImageView)
        peopleStackView.addArrangedSubview(countPeopleLabel)

        likesImageView.snp.makeConstraints { (make) in
            make.width.equalTo(16)
            make.height.equalTo(14)
        }

        countLikesLabel.snp.makeConstraints { (make) in
            make.width.equalTo(40)
        }

        likesStackView.addArrangedSubview(likesImageView)
        likesStackView.addArrangedSubview(countLikesLabel)

        chatImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(20)
        }

        countChatMessagesLabel.snp.makeConstraints { (make) in
            make.width.equalTo(40)
        }

        chatStackView.addArrangedSubview(chatImageView)
        chatStackView.addArrangedSubview(countChatMessagesLabel)

        bottomRightImageView.snp.makeConstraints { (make) in
            make.width.equalTo(5)
            make.height.equalTo(9)
        }

        shareStackView.addArrangedSubview(bottomRightLabel)
        shareStackView.addArrangedSubview(bottomRightImageView)

        allStackViews.addArrangedSubview(peopleStackView)
        allStackViews.addArrangedSubview(likesStackView)
        allStackViews.addArrangedSubview(chatStackView)
        allStackViews.addArrangedSubview(shareStackView)

        let blurEffect = UIBlurEffect(style: .light)
        blurView.effect = blurEffect

        imageViewCourse.addSubview(blurView)
        blurView.contentView.addSubview(countTaskLabel)
        countTaskLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        blurView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(12)
        }
    }
}

