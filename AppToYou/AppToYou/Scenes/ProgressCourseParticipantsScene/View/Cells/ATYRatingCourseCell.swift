//
//  ATYRatingCourseCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 23.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYRatingCourseCell : UITableViewCell {

    let ratingLabel : UILabel = {
        let label = UILabel()
        label.text = "Рейтинг задач курса"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let succesLabel : UILabel = {
        let label = UILabel()
        label.text = "Выполнено"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let failedLabel : UILabel = {
        let label = UILabel()
        label.text = "Пропущено"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        label.textColor = R.color.titleTextColor()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        backgroundColor = R.color.backgroundAppColor()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(ratingLabel)
        contentView.addSubview(succesLabel)
        contentView.addSubview(failedLabel)

        ratingLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(5)
        }

        failedLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-24)
            make.top.equalTo(ratingLabel.snp.bottom).offset(12)
            make.bottom.equalToSuperview().offset(-10)
        }

        succesLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(failedLabel.snp.leading).offset(-10)
            make.centerY.equalTo(failedLabel)
        }
    }
}
