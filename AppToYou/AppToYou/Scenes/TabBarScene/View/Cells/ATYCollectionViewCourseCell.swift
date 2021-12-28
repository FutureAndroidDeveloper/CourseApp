//
//  ATYCollectionViewCourseCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 04.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYCollectionViewCourseCell: UICollectionViewCell {

    let backgroundViewCell : UIView = {
        let view = UIView()
        view.backgroundColor = R.color.backgroundTextFieldsColor()
        return view
    }()

    let labelNameTypeCourse : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textAlignment = .center
        label.textColor = R.color.titleTextColor()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUp(text: String?) {
        self.labelNameTypeCourse.text = text
    }

    private func configure() {
        contentView.addSubview(backgroundViewCell)
        backgroundViewCell.addSubview(labelNameTypeCourse)

        labelNameTypeCourse.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        backgroundViewCell.layer.cornerRadius = 18
        backgroundViewCell.snp.makeConstraints { (make) in
            make.height.equalTo(36)
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}
