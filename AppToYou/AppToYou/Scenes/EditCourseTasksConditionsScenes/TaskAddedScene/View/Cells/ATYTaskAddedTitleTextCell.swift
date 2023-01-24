//
//  ATYTaskAddedTitleTextCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 20.07.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYTaskAddedTitleTextCell : UITableViewCell {

    let nameTaskLabel : UILabel = {
        let label = UILabel()
        label.text = "Задача добавлена"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()

    let textImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.warningImage()
        return imageView
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
        contentView.addSubview(nameTaskLabel)
        contentView.addSubview(textImageView)
        contentView.addSubview(lineView)

        textImageView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(15)
            make.width.height.equalTo(30)
        }

        nameTaskLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalTo(textImageView)
            make.trailing.equalTo(textImageView.snp.leading).offset(-10)
        }

        lineView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(nameTaskLabel.snp.bottom).offset(21)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
}
