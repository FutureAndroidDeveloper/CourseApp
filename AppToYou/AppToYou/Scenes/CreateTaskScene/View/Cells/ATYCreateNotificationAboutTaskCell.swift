//
//  ATYNotificationAboutTaskCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 31.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class CreateNotificationAboutTaskCellModel {
    typealias Callback = () -> Void
    
    let callback: Callback
    let plusCallback: Callback
    
    init(callback: @escaping Callback, plusCallback: @escaping Callback) {
        self.callback = callback
        self.plusCallback = plusCallback
    }
    
}


class ATYCreateNotificationAboutTaskCell: UITableViewCell, InflatableView {
    
    func inflate(model: AnyObject) {
        guard let model = model as? CreateNotificationAboutTaskCellModel else {
            return
        }
        
        callBack = model.callback
        plusCallBack = model.plusCallback
    }

    var nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Напоминание о задаче"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        label.backgroundColor = R.color.backgroundAppColor()
        return label
    }()

    var notificationsViews = [ATYNotificationAboutTaskView]()

    var stackView = UIStackView()

    var callBack: (() -> Void)?
    var plusCallBack: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        selectionStyle = .none
        backgroundColor = R.color.backgroundAppColor()
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        setUp(notificationCount: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUp(notificationCount: Int) {
        notificationsViews.removeAll()
        stackView.removeFromSuperview()
        stackView.removeFullyAllArrangedSubviews()
        for i in 0..<notificationCount {
            let mainView = ATYNotificationAboutTaskView()
            mainView.plusButton.isHidden = i != notificationCount - 1
            mainView.callback = { [weak self] in
                self?.callBack?()
            }
            mainView.plusCallback = { [weak self] in
                self?.plusCallBack?()

            }
            notificationsViews.append(mainView)
        }

        contentView.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0


        for view in notificationsViews {
            stackView.addArrangedSubview(view)
        }

        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
