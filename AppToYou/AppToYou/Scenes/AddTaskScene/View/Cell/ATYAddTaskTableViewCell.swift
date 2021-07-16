//
//  ATYAddTaskTableViewCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 26.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYCreateTaskTableViewCell: UITableViewCell {
    private let backContentView : UIView = {
        let view = UIView()
        view.backgroundColor = R.color.backgroundTableCellColor()
        return view
    }()

    private let typeImageView = UIImageView()

    private let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = R.color.titleTextColor()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    private let subtitleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = R.color.textSecondaryColor()
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUp(image: UIImage?, titleLabel: String, subtitleLabel: String) {
        guard let image = image else { return }
        self.typeImageView.image = image
        self.titleLabel.text = titleLabel
        self.subtitleLabel.text = subtitleLabel
    }

    private func configureViews() {
        contentView.addSubview(backContentView)
        backContentView.layer.cornerRadius = 24
        backContentView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(3)
            make.trailing.equalToSuperview().offset(-3)
            make.top.equalToSuperview().offset(3)
            make.bottom.equalToSuperview().offset(-3)
        }

        backContentView.addSubview(typeImageView)

        typeImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
            make.width.height.equalTo(50)
        }

        backContentView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(typeImageView.snp.trailing).offset(12)
            make.top.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }

        backContentView.addSubview(subtitleLabel)

        subtitleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(typeImageView.snp.trailing).offset(12)
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
        }

    }
}
