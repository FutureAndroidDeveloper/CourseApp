//
//  ATYDescriptionAboutCourse.swift
//  AppToYou
//
//  Created by Philip Bratov on 09.06.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYDescriptionAboutCourse: UITableViewCell {

    var topConstraintButton = NSLayoutConstraint()

    let nameCourseLabel : UILabel = {
        let label = UILabel()
        label.text = "Ментальное здоровье"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let likeButton : UIButton = {
        let button = UIButton()
        button.setImage(R.image.likesView(), for: .normal)
        button.setImage(R.image.filledRedLike(), for: .selected)
        return button
    }()

    let labelCountLikes : UILabel = {
        let label = UILabel()
        label.text = "123"
        label.textAlignment = .right
        label.textColor = R.color.textSecondaryColor()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.textColor = R.color.textSecondaryColor()
        label.text = "Существует тесная взаимосвязь между психикой и физическим состоянием человека. Чувство тревоги, постоянные длинный текст, как пример, классный курс"
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 3
        return label
    }()

    let membersOfCourseButton : UIButton = {
        let button = UIButton()
        button.setTitle("Участники курса", for: .normal)
        button.backgroundColor = R.color.backgroundTextFieldsColor()
        button.setTitleColor(R.color.titleTextColor(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setImage(R.image.addMemberimage(), for: .normal)
        return button
    }()

    let signInChatButton : UIButton = {
        let button = UIButton()
        button.setTitle("Войти в чат курса", for: .normal)
        button.backgroundColor = R.color.backgroundTextFieldsColor()
        button.setTitleColor(R.color.titleTextColor(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setImage(R.image.chatImage(), for: .normal)
        return button
    }()

    let countMembersLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = R.color.textColorSecondary()
        label.text = "(+2)"
        return label
    }()

    let countChatMembersLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = R.color.textColorSecondary()
        label.text = "(+2)"
        return label
    }()

    var callbackMembers: (() -> ())?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUp(isMyCourse: Bool) {
        if !isMyCourse {
            self.membersOfCourseButton.isHidden = true
            self.topConstraintButton.isActive = false
            self.topConstraintButton = signInChatButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16)
            self.topConstraintButton.isActive = true
        }
    }

    @objc func likeButtonAction() {
        likeButton.isSelected = !likeButton.isSelected
    }

    @objc func membersOfCourseButtonAction() {
        callbackMembers?()
    }

    private func configure() {
        contentView.addSubview(nameCourseLabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(labelCountLikes)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(membersOfCourseButton)
        contentView.addSubview(signInChatButton)

        likeButton.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
        likeButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(5)
            make.width.equalTo(16)
            make.height.equalTo(14)
        }

        labelCountLikes.snp.makeConstraints { (make) in
            make.trailing.equalTo(likeButton.snp.leading).offset(-8.5)
            make.centerY.equalTo(likeButton)
            make.width.equalTo(labelCountLikes.intrinsicContentSize.width)
        }

        nameCourseLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalTo(labelCountLikes)
            make.trailing.equalTo(labelCountLikes.snp.leading).offset(-10)
        }

        descriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(nameCourseLabel)
            make.top.equalTo(nameCourseLabel.snp.bottom).offset(14)
            make.trailing.equalToSuperview().offset(-20)
        }

        let spacing : CGFloat = 10
        membersOfCourseButton.addTarget(self, action: #selector(membersOfCourseButtonAction), for: .touchUpInside)
        membersOfCourseButton.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        membersOfCourseButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        membersOfCourseButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        membersOfCourseButton.layer.cornerRadius = 25
        membersOfCourseButton.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        self.topConstraintButton = signInChatButton.topAnchor.constraint(equalTo: membersOfCourseButton.bottomAnchor, constant: 12)
        self.topConstraintButton.isActive = true
        signInChatButton.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        signInChatButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        signInChatButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        signInChatButton.layer.cornerRadius = 25
        signInChatButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-5)
        }

        membersOfCourseButton.addSubview(countMembersLabel)
        countMembersLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.width.lessThanOrEqualTo(50)
            make.centerY.equalToSuperview()
        }

        signInChatButton.addSubview(countChatMembersLabel)
        countChatMembersLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.width.lessThanOrEqualTo(50)
            make.centerY.equalToSuperview()
        }
    }
}
