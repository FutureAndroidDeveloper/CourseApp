//
//  ATYTheCostCourseCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 22.07.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYTheCostCourseCell : UITableViewCell {

    enum  ATYRadioButtonsType {
        case coin
        case diamond
    }

    let costCourseLabel : UILabel = {
        let label = UILabel()
        label.text = "Стоимость курса"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = R.color.textSecondaryColor()
        return label
    }()

    let chooseCurrencyLabel : UILabel = {
        let label = UILabel()
        label.text = "Выберите валюту"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = R.color.textSecondaryColor()
        return label
    }()

    let howMuchCostLabel : UILabel = {
        let label = UILabel()
        label.text = "100"
        label.font = UIFont.systemFont(ofSize: 36)
        return label
    }()

    let coinImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.coinImage()
        return imageView
    }()

    let diamondImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.diamondImage()
        return imageView
    }()

    let coinCountLabel : UILabel = {
        let label = UILabel()
        label.text = "15"
        return label
    }()

    let diamondCountLabel : UILabel = {
        let label = UILabel()
        label.text = "300"
        return label
    }()

    let coinCountImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.coinImage()
        return imageView
    }()

    let diamondCountImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.diamondImage()
        return imageView
    }()

    //Radio buttons

    let radioController: RadioButtonController = RadioButtonController()

    let coinButton : UIButton = {
        let button = UIButton()
        button.setImage(R.image.unselectedRadioButton(), for: .normal)
        button.setImage(R.image.selectedRadioButton(), for: .selected)
        return button
    }()

    let diamondButton : UIButton = {
        let button = UIButton()
        button.setImage(R.image.unselectedRadioButton(), for: .normal)
        button.setImage(R.image.selectedRadioButton(), for: .selected)
        return button
    }()

    var paidTypeCallback : ((ATYRadioButtonsType) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        selectionStyle = .none
        radioController.buttonsArray = [coinButton, diamondButton]
        radioController.defaultButton = coinButton
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(costCourseLabel)
        contentView.addSubview(chooseCurrencyLabel)
        contentView.addSubview(howMuchCostLabel)
        contentView.addSubview(coinImage)
        contentView.addSubview(diamondImage)
        contentView.addSubview(diamondCountLabel)
        contentView.addSubview(coinCountLabel)
        contentView.addSubview(coinCountImage)
        contentView.addSubview(diamondCountImage)
        contentView.addSubview(coinButton)
        contentView.addSubview(diamondButton)


        costCourseLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview()
        }

        costCourseLabel.widthAnchor.constraint(equalToConstant: costCourseLabel.intrinsicContentSize.width).isActive = true

        chooseCurrencyLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(costCourseLabel)
        }

        chooseCurrencyLabel.widthAnchor.constraint(equalToConstant: chooseCurrencyLabel.intrinsicContentSize.width).isActive = true

        howMuchCostLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(costCourseLabel)
            make.top.equalTo(costCourseLabel.snp.bottom).offset(6)
        }

        howMuchCostLabel.widthAnchor.constraint(equalToConstant: howMuchCostLabel.intrinsicContentSize.width).isActive = true

        coinImage.snp.makeConstraints { (make) in
            make.leading.equalTo(howMuchCostLabel.snp.trailing).offset(4)
            make.top.equalTo(howMuchCostLabel).offset(10)
            make.width.height.equalTo(10.5)
        }

        diamondImage.snp.makeConstraints { (make) in
            make.leading.equalTo(coinImage.snp.trailing).offset(4)
            make.top.equalTo(coinImage)
            make.width.height.equalTo(10.5)
        }

        //configure cost coin

        coinButton.addTarget(self, action: #selector(actionRadioButtonCoin), for: .touchUpInside)
        coinButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(chooseCurrencyLabel)
            make.top.equalTo(diamondImage)
            make.width.height.equalTo(15)
        }

        coinCountImage.snp.makeConstraints { (make) in
            make.trailing.equalTo(coinButton.snp.leading).offset(-13)
            make.centerY.equalTo(coinButton)
            make.width.height.equalTo(10.5)
        }

        coinCountLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(coinCountImage.snp.leading).offset(-4.75)
            make.centerY.equalTo(coinCountImage)
        }

        coinCountLabel.widthAnchor.constraint(equalToConstant: coinCountLabel.intrinsicContentSize.width).isActive = true

        //configure cost diamond

        diamondButton.addTarget(self, action: #selector(actionRadioButtonDiamond), for: .touchUpInside)
        diamondButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(coinButton)
            make.top.equalTo(coinButton.snp.bottom).offset(17)
            make.width.height.equalTo(15)
        }

        diamondCountImage.snp.makeConstraints { (make) in
            make.trailing.equalTo(diamondButton.snp.leading).offset(-13)
            make.centerY.equalTo(diamondButton)
            make.width.height.equalTo(10.5)
        }

        diamondCountLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(diamondCountImage.snp.leading).offset(-4.75)
            make.centerY.equalTo(diamondCountImage)
            make.bottom.equalToSuperview().offset(-10)
        }

        diamondCountLabel.widthAnchor.constraint(equalToConstant: diamondCountLabel.intrinsicContentSize.width).isActive = true
    }

    @objc func actionRadioButtonCoin(_ sender: UIButton) {
        paidTypeCallback?(.coin)
        radioController.buttonArrayUpdated(buttonSelected: sender)
    }

    @objc func actionRadioButtonDiamond(_ sender: UIButton) {
        paidTypeCallback?(.diamond)
        radioController.buttonArrayUpdated(buttonSelected: sender)
    }
}
