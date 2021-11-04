//
//  ATYProfileWithoutSignInAboutAppCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 28.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYAboutAppCell : UITableViewCell {

    let cardView = ATYCardView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(cardView)

        cardView.largeTitleLabel.text = "О приложении"
        cardView.firstImageView.image = R.image.bagImage()
        cardView.secondImageView.image = R.image.certificateImage()
        cardView.thirdImageView.image = R.image.versionAppImage()

        cardView.firstButton.setTitle("Политика приложения", for: .normal)
        cardView.secondButton.setTitle("Пользовательское соглашение", for: .normal)
        cardView.thirdButton.setTitle("Версия приложения 1.67.4", for: .normal)

        cardView.layer.cornerRadius = 25
        cardView.layer.masksToBounds = true
        cardView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}