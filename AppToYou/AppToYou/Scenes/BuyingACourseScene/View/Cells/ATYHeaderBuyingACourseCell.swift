//
//  ATYHeaderBuyingACourseCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 22.07.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYHeaderBuyingACourseCell : UITableViewCell {

    let buingCourseLabel : UILabel = {
        let label = UILabel()
        label.text = "Купить курс «Идеальное тело»"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    let descriptionBuingCourseLabel : UILabel = {
        let label = UILabel()
        label.text = "Вы можете использовать как купленные монеты, так и заработанные алмазы"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = R.color.textSecondaryColor()
        label.numberOfLines = 0
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
        contentView.addSubview(buingCourseLabel)
        contentView.addSubview(descriptionBuingCourseLabel)

        buingCourseLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }

        descriptionBuingCourseLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(buingCourseLabel.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
