//
//  ATYEditCourseCountRepeatTaskCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 16.07.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYEditCountCourseTaskTimeCell : UITableViewCell {

    let nameTaskLabel : UILabel = {
        let label = UILabel()
        label.text = "Отжимания"
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

    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "Выберите оптимальную для вас длительность выполнения задачи"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()

    let countLabel : UILabel = {
        let label = UILabel()
        label.text = "100"
        label.textColor = R.color.textColorSecondary()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .right
        return label
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
        contentView.addSubview(countLabel)
        contentView.addSubview(descriptionLabel)

        countLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(15)
            make.width.equalTo(countLabel.intrinsicContentSize.width)
        }

        nameTaskLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalTo(countLabel.snp.top)
            make.trailing.equalTo(countLabel.snp.leading).offset(-10)
        }

        executionFrequencyLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(nameTaskLabel.snp.bottom).offset(6)
            make.trailing.equalTo(countLabel.snp.leading).offset(-10)
        }

        descriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(executionFrequencyLabel.snp.bottom).offset(32)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
