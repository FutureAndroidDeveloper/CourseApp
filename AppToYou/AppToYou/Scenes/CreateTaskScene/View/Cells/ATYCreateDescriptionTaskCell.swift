//
//  ATYCreateDescriptionTaskCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 31.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYCreateDescriptionTaskCell: UITableViewCell {

    var nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Описание задачи"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    var descriptionTextView : UITextView = {
        let textView = UITextView()
        textView.textColor = R.color.titleTextColor()
        textView.font = UIFont.systemFont(ofSize: 15)
        return textView
    }()

    let placeholderLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionTextView)

        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        descriptionTextView.delegate = self
        descriptionTextView.layer.cornerRadius = 20
        placeholderLabel.text = "Например, положительные моменты"
        placeholderLabel.font = UIFont.systemFont(ofSize: (descriptionTextView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        descriptionTextView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (descriptionTextView.font?.pointSize)! / 2)
        placeholderLabel.textColor = R.color.textSecondaryColor()
        placeholderLabel.isHidden = !descriptionTextView.text.isEmpty



        descriptionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(125)
            make.bottom.equalToSuperview().offset(-15)
        }

    }
}

extension ATYCreateDescriptionTaskCell : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
