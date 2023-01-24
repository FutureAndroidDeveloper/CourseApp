//
//  ATYTaskAddedDescriptionsCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 20.07.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYTaskAddedDescriptionsCell : UITableViewCell {

    let firstLabel : UILabel = {
        let label = UILabel()
        label.text = "Мы учли ваши корректировки и продублировали задачу в ваших личных задачах с пометкой «курс»."
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()

    let secondLabel : UILabel = {
        let label = UILabel()
        label.text = "Ваш прогресс по задачам курса доступен участникам курса."
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()

    let lineView : UIView = {
        let view = UIView()
        view.backgroundColor = R.color.backgroundTableCellColor()
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(firstLabel)
        contentView.addSubview(secondLabel)
        contentView.addSubview(lineView)

        firstLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(30)
        }

        secondLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(firstLabel.snp.bottom).offset(21)
        }

        lineView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(secondLabel.snp.bottom).offset(30)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
}
