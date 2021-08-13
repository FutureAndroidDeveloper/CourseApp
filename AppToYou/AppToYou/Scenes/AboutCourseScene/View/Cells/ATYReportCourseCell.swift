//
//  ATYReportCourseCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 16.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYReportCourseCell: UITableViewCell {

    let reportImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.reportImage()
        return imageView
    }()

    let reportLabel : UILabel = {
        let reportLabel = UILabel()
        reportLabel.text = "Пожаловаться на курс"
        reportLabel.font = UIFont.systemFont(ofSize: 15)
        return reportLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        selectionStyle = .none
        backgroundColor = R.color.backgroundAppColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(reportImageView)
        contentView.addSubview(reportLabel)

        reportImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(25)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(24)
        }

        reportLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(reportImageView)
            make.leading.equalTo(reportImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-40)
        }
    }
}
