//
//  ATYSaveTaskCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 31.05.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class SaveTaskCellModel {
    let callback: (() -> Void)
    
    init(callback: @escaping () -> Void) {
        self.callback = callback
    }
    
}

class ATYSaveTaskCell: UITableViewCell, InflatableView {

    private var callback: (() -> Void)?
    
    var saveButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(R.color.backgroundTextFieldsColor(), for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
        configure()
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? SaveTaskCellModel else {
            return
        }
        callback = model.callback
    }

    func setUp(titleForButton: String) {
        self.saveButton.setTitle(titleForButton, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(saveButton)

        saveButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        saveButton.layer.cornerRadius = 22.5
        saveButton.snp.makeConstraints { (make) in
            make.leading.top.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(45)
        }
    }

    @objc func buttonTapped() {
        callback?()
    }
}
