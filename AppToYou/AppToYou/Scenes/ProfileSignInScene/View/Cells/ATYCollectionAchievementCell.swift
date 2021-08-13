//
//  ATYCollectionAchievementCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 29.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYCollectionAchievementCell: UICollectionViewCell {

    let achiemenentImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = R.color.backgroundTextFieldsColor()
        return imageView
    }()

    let nameAchievementLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let progressView : UIProgressView = {
        let progressView = UIProgressView()
        progressView.backgroundColor = R.color.lightGrayColor()
        progressView.progressTintColor = R.color.succesColor()
        progressView.progress = 0.7
        return progressView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        backgroundColor = R.color.backgroundTextFieldsColor()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUp(image : UIImage? , text: String) {
        self.nameAchievementLabel.text = text
        self.achiemenentImageView.image = image
    }

    private func configure() {
        contentView.addSubview(achiemenentImageView)
        contentView.addSubview(nameAchievementLabel)
        contentView.addSubview(progressView)

        achiemenentImageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(17)
            make.top.equalToSuperview().offset(10)
            make.height.width.equalTo(65)
        }

        nameAchievementLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(achiemenentImageView.snp.bottom).offset(6)
        }

        progressView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.top.equalTo(nameAchievementLabel.snp.bottom).offset(27)
            make.bottom.equalToSuperview()
            make.height.equalTo(4)
        }
    }
}
