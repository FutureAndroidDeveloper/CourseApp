//
//  ATYPaidCoursePreviewDescriptionCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 21.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYPaidCoursePreviewDescriptionCell : UITableViewCell {

    let descriptionTextView : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "Существует тесная взаимосвязь между психикой и физическим состоянием человека. Чувство тревоги, постоянные тревоги. Существует тесная взаимосвязь между психикой и физическим состоянием человека. Чувство тревоги, постоянные тревоги. Существует тесная взаимосвязь между психикой и физическим состоянием человека. Чувство тревоги, постоянные тревоги. Существует тесная взаимосвязь между психикой и физическим состоянием человека. Чувство тревоги, постоянные тревоги."
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(descriptionTextView)
        descriptionTextView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-25)
        }
    }
}
