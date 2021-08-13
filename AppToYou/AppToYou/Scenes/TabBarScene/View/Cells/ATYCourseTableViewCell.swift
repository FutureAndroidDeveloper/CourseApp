//
//  ATYCourseTableViewCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 04.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYCourseTableViewCell : UITableViewCell {

    var widthConstraint = NSLayoutConstraint()
    var widthConstraintLikesLabel = NSLayoutConstraint()
    var widthConstraintCoinLabel = NSLayoutConstraint()
    var stackViewLabel = NSLayoutConstraint()

    let backgroundViewCell : UIView = {
        let view = UIView()
        view.backgroundColor = R.color.backgroundTextFieldsColor()
        return view
    }()

    let imageViewCourse : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let gradientImageView : ATYGradientImageView = {
        let imageView = ATYGradientImageView(frame: .zero)
        return imageView
    }()

    let typeOfCourseLabel : UILabel = {
        let label = UILabel()
        label.text = "открытый курс | мой курс"
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
        label.textColor = R.color.titleTextColor()
        label.numberOfLines = 3
        return label
    }()

    //MARK:- Images views for bottom view

    let peopleImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.whitePeople()
        return imageView
    }()

    let likesImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.whiteLike()
        return imageView
    }()

    //MARK:- Labels for bottom view

    let countPeopleLabel : UILabel = {
        let label = UILabel()
        label.text = "1 428"
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = R.color.backgroundTextFieldsColor()
        return label
    }()

    let countLikesLabel : UILabel = {
        let label = UILabel()
        label.text = "122"
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = R.color.backgroundTextFieldsColor()
        return label
    }()

    //MARK:- Stack views

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
        imageView.image = R.image.rightArrowImage()
        return imageView
    }()

    let coinImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.coinImage()
        return imageView
    }()

    let countTaskLabel : UILabel = {
        let label = UILabel()
        label.text = "10 монет"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        label.textColor = R.color.backgroundTextFieldsColor()
        return label
    }()

    var typeOfCourse: ATYCourseType!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
        configure()
    }

    func setUp(courseName: String,
               categories: [ATYCourseCategory],
               countOfCoin: Int?,
               countOfMembers: Int,
               countOfLikes: Int,
               typeOfCourse: ATYCourseType,
               isMyCourse: Bool,
               avatarPath: String?,
               courseDescription: String?) {
        self.typeOfCourse = typeOfCourse
        for i in 0..<categories.count {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 13)
            label.textColor = R.color.textSecondaryColor()
            label.layer.borderWidth = 1
            label.layer.borderColor = R.color.borderColor()?.cgColor
            label.layer.cornerRadius = 12
            label.textAlignment = .center
            label.heightAnchor.constraint(equalToConstant: 24).isActive = true
            label.text = categories[i].title
            allStackViews.addArrangedSubview(label)
        }
        descriptionCourseLabel.text = courseDescription
        imageViewCourse.image = UIImage(imageName: avatarPath ?? "")
        nameCourseLabel.text = courseName
        countTaskLabel.text = countOfCoin == nil ? "" : String(countOfCoin!) + " монет"
        coinImageView.isHidden = countOfCoin == nil
        countPeopleLabel.text = String(countOfMembers)
        countLikesLabel.text = String(countOfLikes)

        let isMyCourseText = isMyCourse ? " | мой курс" : ""
        switch typeOfCourse {
        case .PRIVATE:
            typeOfCourseLabel.text = "закрытый курс" + isMyCourseText
            bottomRightImageView.image = R.image.chain()?.withTintColor(R.color.textColorSecondary() ?? .orange)
        case .PUBLIC:
            typeOfCourseLabel.text = "открытый курс" + isMyCourseText
            bottomRightImageView.image = R.image.rightArrowImage()
        case .PAID:
            typeOfCourseLabel.text = "платный курс" + isMyCourseText
            bottomRightImageView.image = R.image.walletTwoImage()
        }

        widthConstraintCoinLabel.isActive = false
        widthConstraintCoinLabel = countTaskLabel.widthAnchor.constraint(equalToConstant: countTaskLabel.intrinsicContentSize.width)
        widthConstraintCoinLabel.isActive = true

        widthConstraintLikesLabel.isActive = false
        widthConstraintLikesLabel = countLikesLabel.widthAnchor.constraint(equalToConstant: countLikesLabel.intrinsicContentSize.width)
        widthConstraintLikesLabel.isActive = true

        widthConstraint.isActive = false
        widthConstraint = countPeopleLabel.widthAnchor.constraint(equalToConstant: countPeopleLabel.intrinsicContentSize.width)
        widthConstraint.isActive = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        allStackViews.removeFullyAllArrangedSubviews()
        countTaskLabel.text = nil
        countPeopleLabel.text = nil
        countLikesLabel.text = nil
        typeOfCourseLabel.text = nil
        coinImageView.isHidden = false
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

        imageViewCourse.addSubview(gradientImageView)
        gradientImageView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.top.equalToSuperview()
        }

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
        gradientImageView.addSubview(coinImageView)
        coinImageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(21)
            make.bottom.equalToSuperview().offset(-14)
            make.width.height.equalTo(14)
        }

        gradientImageView.addSubview(countTaskLabel)
        countTaskLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(coinImageView.snp.trailing).offset(9)
            make.centerY.equalTo(coinImageView)
        }

        gradientImageView.addSubview(countLikesLabel)
        countLikesLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-22)
            make.centerY.equalTo(coinImageView)
        }

        gradientImageView.addSubview(likesImageView)
        likesImageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(countLikesLabel.snp.leading).offset(-8)
            make.centerY.equalTo(coinImageView)
            make.width.equalTo(16)
            make.height.equalTo(14)
        }

        gradientImageView.addSubview(countPeopleLabel)
        countPeopleLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(likesImageView.snp.leading).offset(-16)
            make.centerY.equalTo(coinImageView)
        }

        gradientImageView.addSubview(peopleImageView)
        peopleImageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(countPeopleLabel.snp.leading).offset(-6)
            make.centerY.equalTo(coinImageView)
            make.width.height.equalTo(16)
        }

        backgroundViewCell.addSubview(bottomRightImageView)
        bottomRightImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(24)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-16)
        }

        backgroundViewCell.addSubview(allStackViews)
        allStackViews.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(24)
            make.centerY.equalTo(bottomRightImageView)
            make.trailing.equalTo(bottomRightImageView.snp.leading).offset(-31)
        }
    }
}

