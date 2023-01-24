//
//  ATYCourseParticipantCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 22.07.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYCourseParticipantCell : UITableViewCell {

    enum ATYTypeCourseUser {
        case member
        case request
    }

    let nameImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = R.color.backgroundTextFieldsColor()
        imageView.tintColor = R.color.backgroundTextFieldsColor()
        return imageView
    }()

    let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let doneButton : UIButton = {
        let button = UIButton()
        button.setImage(R.image.acceptImage(), for: .normal)
        return button
    }()

    let deslineButton : UIButton = {
        let button = UIButton()
        button.setImage(R.image.desclineImage(), for: .normal)
        return button
    }()

    var doneCallback : (() -> ())?
    var deslineCallback : (() -> ())?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUp(participantUserName: String,
               type: Int) {
        nameImageView.image = UIImage(withLettersFromName: participantUserName)
        nameLabel.text = participantUserName
        doneButton.isHidden = type == 2
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        doneButton.isHidden = false
    }

    @objc func doneButtonAction() {
        doneCallback?()
    }

    @objc func deslineButtonAction() {
        deslineCallback?()
    }

    private func configure() {
        contentView.addSubview(nameImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(doneButton)
        contentView.addSubview(deslineButton)

        nameImageView.layer.cornerRadius = 25
        nameImageView.layer.masksToBounds = true
        nameImageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(50)
        }

        deslineButton.addTarget(self, action: #selector(deslineButtonAction), for: .touchUpInside)
        deslineButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(nameImageView)
            make.width.height.equalTo(36)
        }

        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        doneButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(deslineButton.snp.leading).offset(-12)
            make.centerY.equalTo(nameImageView)
            make.width.height.equalTo(36)
        }

        nameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(nameImageView.snp.trailing).offset(16)
            make.trailing.equalTo(doneButton.snp.leading).offset(-5)
            make.centerY.equalTo(nameImageView)
        }

    }
}
