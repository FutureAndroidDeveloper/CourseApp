//
//  ATYPaidCoursePreviewHeaderCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 21.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYPaidCoursePreviewHeaderCell: UITableViewCell {

    enum ATYTypeCell {
        case buying
        case join
    }

    let courseNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Ментальное здоровье"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    let costLabel : UILabel = {
        let label = UILabel()
        label.text = "11 150"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = R.color.textColorSecondary()
        return label
    }()

    let coinImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.coinImage()
        return imageView
    }()

    let peopleImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.peopleImage()
        return imageView
    }()

    let countPeopleLabel : UILabel = {
        let label = UILabel()
        label.text = "1 454"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = R.color.textSecondaryColor()
        return label
    }()

    let likeImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.fillGrayLike()
        return imageView
    }()

    let countLikesLabel : UILabel = {
        let label = UILabel()
        label.text = "123"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = R.color.textSecondaryColor()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    func setUp(type: ATYTypeCell) {
        switch type {
        case .buying:
            courseNameLabel.trailingAnchor.constraint(equalTo: costLabel.leadingAnchor, constant: -10).isActive = true
        case .join:
            courseNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
            costLabel.isHidden = true
            coinImageView.isHidden = true
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(courseNameLabel)
        contentView.addSubview(costLabel)
        contentView.addSubview(coinImageView)
        contentView.addSubview(peopleImageView)
        contentView.addSubview(countPeopleLabel)
        contentView.addSubview(likeImageView)
        contentView.addSubview(countLikesLabel)

        coinImageView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview()
            make.width.height.equalTo(20)
            make.top.equalToSuperview().offset(52)
        }

        costLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(coinImageView.snp.leading).offset(-8.5)
            make.centerY.equalTo(coinImageView)
            make.width.equalTo(costLabel.intrinsicContentSize.width)
        }

        courseNameLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.centerY.equalTo(coinImageView)
        }

        peopleImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(courseNameLabel)
            make.top.equalTo(courseNameLabel.snp.bottom).offset(16.5)
            make.width.height.equalTo(16)
            make.bottom.equalToSuperview().offset(-15)
        }

        countPeopleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(peopleImageView.snp.trailing).offset(8.5)
            make.centerY.equalTo(peopleImageView)
            make.width.equalTo(countPeopleLabel.intrinsicContentSize.width)
        }

        likeImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(countPeopleLabel.snp.trailing).offset(15.5)
            make.width.equalTo(16)
            make.height.equalTo(14)
            make.centerY.equalTo(countPeopleLabel)
        }

        countLikesLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(likeImageView.snp.trailing).offset(8.5)
            make.centerY.equalTo(likeImageView)
            make.width.equalTo(countPeopleLabel.intrinsicContentSize.width)
        }
    }
    
}
