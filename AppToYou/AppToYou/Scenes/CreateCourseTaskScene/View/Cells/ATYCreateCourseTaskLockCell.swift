//
//  ATYCreateCourseTaskLockCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 21.06.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYCreateCourseTaskLockCell : UITableViewCell {

    let lockLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.numberOfLines = 2
        label.text = "Нажмите на замок, чтобы сделать параметр недоступным для редактирования пользователем"
        return label
    }()

    let lockImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.openCourseImage()?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = R.color.textColorSecondary()
        return imageView
    }()

    let separatorView : UIView = {
        let view = UIView()
        view.backgroundColor = R.color.separatorColor()
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = R.color.backgroundAppColor()
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(lockLabel)
        contentView.addSubview(lockImageView)
        contentView.addSubview(separatorView)

        lockImageView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(24)
        }

        lockLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalTo(lockImageView)
            make.trailing.equalTo(lockImageView.snp.leading).offset(-19)
        }

        separatorView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1.5)
        }
    }
}
