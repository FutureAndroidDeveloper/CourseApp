//
//  ATYCustomCourseNavigationBar.swift
//  AppToYou
//
//  Created by Philip Bratov on 06.08.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYCustomCourseNavigationBar : UIView {
    let imageViewFirst = UIImageView()
    let imageViewSecond = UIImageView()
    let imageViewThird = UIImageView()

    let courseLabel: UILabel = {
        let label = UILabel()
        label.text = "Курсы"
        label.font = UIFont.systemFont(ofSize: 28)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()

    let descriptionCourseLabel: UILabel = {
        let label = UILabel()
        label.text = "присоединись к курсу и найди поддержку среди его участников"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    let blurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView()
        blurView.layer.cornerRadius = 20
        blurView.clipsToBounds = true
        return blurView
    }()

    let doneButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.setTitle("Создать курс  ", for: .normal)
        button.setImage(R.image.plusCourseButton(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addShape()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var createCourseCallback: (() -> Void)?

    @objc func doneButtonAction() {
        createCourseCallback?()
    }

    private func addShape() {
        self.addSubview(imageViewFirst)
        self.addSubview(imageViewSecond)
        self.addSubview(imageViewThird)
        self.addSubview(blurView)

        let blurEffect = UIBlurEffect(style: .light)
        blurView.effect = blurEffect

        imageViewFirst.image = R.image.shapeImage()
        imageViewSecond.image = R.image.shapeSecondImage()
        imageViewThird.image = R.image.shapeThirdImage()

        imageViewFirst.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(100)
        }

        imageViewSecond.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(30)
        }

        imageViewThird.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(45)
            make.height.width.equalTo(120)
            make.top.equalTo(imageViewFirst.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }

        blurView.snp.makeConstraints { (make) in
            make.top.equalTo(imageViewSecond.snp.centerY)
            make.leading.equalToSuperview()
            make.bottom.equalTo(imageViewThird.snp.bottom).offset(-10)
            make.width.equalToSuperview().multipliedBy(0.8)
        }

        blurView.contentView.addSubview(courseLabel)
        blurView.contentView.addSubview(descriptionCourseLabel)

        courseLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(35)
        }

        descriptionCourseLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(courseLabel.snp.bottom)
            make.height.equalTo(50)
        }

        self.addSubview(doneButton)

        doneButton.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft

        doneButton.layer.cornerRadius = 20

        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)

        doneButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(blurView.snp.bottom)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
            make.width.equalTo(155)
        }

    }
}
