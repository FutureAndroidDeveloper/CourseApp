//
//  ATYMembersAboutCourseCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 21.06.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYMembersAboutCourseCell : UITableViewCell {
    let watchMembersCourseLabel : UILabel = {
        let label = UILabel()
        label.text = "Следите за успехами участников курса и делитесь своими!"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 2
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let membersImageView : ATYMembersView = {
        let imageView = ATYMembersView()
        return imageView
    }()

    let bottomRightLabel : UILabel = {
        let label = UILabel()
        label.text = "Посмотреть"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14,weight: .medium)
        label.sizeToFit()
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let bottomRightImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.shareImage()
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
        contentView.addSubview(watchMembersCourseLabel)
        contentView.addSubview(membersImageView)
        contentView.addSubview(bottomRightLabel)
        contentView.addSubview(bottomRightImageView)

        watchMembersCourseLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
        }

        membersImageView.snp.makeConstraints { (make) in
            make.top.equalTo(watchMembersCourseLabel.snp.bottom).offset(24)
            make.leading.equalTo(watchMembersCourseLabel)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }

        bottomRightImageView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(membersImageView)
            make.width.equalTo(5)
            make.height.equalTo(9)
            make.bottom.equalToSuperview().offset(-15)
        }

        bottomRightLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(bottomRightImageView.snp.leading).offset(-9)
            make.centerY.equalTo(bottomRightImageView)
            make.width.equalTo(bottomRightLabel.intrinsicContentSize)
        }
    }
}

class ATYMembersView: UIView {

    let imageArray = [R.image.human1(), R.image.human2(), R.image.human3(), R.image.human4(), R.image.human5()]
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.sublayers?.forEach({ (layer) in
            layer.removeFromSuperlayer()
        })
        self.drowParticipants()
    }

    let label = UILabel()
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

    private func drowParticipants() {
        label.text = "+1 345"
        imageView.backgroundColor = R.color.textColorSecondary()
        imageView.layer.cornerRadius = 25
        imageView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        let recipientsCount = imageArray.count + 1

        let pictureWidthAndHeight: CGFloat = 50

        let recipientsStartWithX: CGFloat = 0

        for i in 0..<recipientsCount {
            let pictureLayer = CALayer()
            pictureLayer.frame = CGRect(x: recipientsStartWithX + CGFloat(i)*(pictureWidthAndHeight-20),
                                        y: 0,
                                        width: pictureWidthAndHeight,
                                        height: pictureWidthAndHeight)

            if i == recipientsCount - 1 {
                pictureLayer.contents = R.image.oneTheFourFive()?.cgImage
            } else {
                pictureLayer.contents = imageArray[i]?.cgImage
            }

            pictureLayer.contentsGravity = .resize
            pictureLayer.magnificationFilter = .linear
            pictureLayer.backgroundColor = R.color.backgroundAppColor()?.cgColor
            pictureLayer.masksToBounds = true
            pictureLayer.cornerRadius = 25

            layer.insertSublayer(pictureLayer, at: UInt32(i))
        }
    }
}
