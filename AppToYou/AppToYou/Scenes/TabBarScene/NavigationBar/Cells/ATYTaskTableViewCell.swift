//
//  ATYTaskTableViewCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 27.05.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

@available(*, deprecated, message: "old version")
class ATYTaskTableViewCell: UITableViewCell {

    enum UserOrCourseTask {
        case user
        case course
    }

    let backContentView : UIView = {
        let view = UIView()
        view.backgroundColor = R.color.backgroundTextFieldsColor()
        return view
    }()

    private let backContentViewBorder : UIView = {
        let view = UIView()
        view.backgroundColor = R.color.textColorSecondary()
        view.isHidden = true
        return view
    }()

    private let startTaskButton : UIButton = {
        let button = UIButton()
        return button
    }()

    private let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    private let firstSubtitle : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = R.color.textSecondaryColor()
        return label
    }()

    private let secondSubtitle : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = R.color.textSecondaryColor()
        return label
    }()

    private let dotView : UIView = {
        let view = UIView()
        view.backgroundColor = R.color.textSecondaryColor()
        return view
    }()

    private let courseLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = R.color.titleTextColor()
        label.clipsToBounds = true
        label.backgroundColor = R.color.backgroundButtonCard()
        return label
    }()

    private let sanctionImageView : UIImageView = {
        let view = UIImageView()
        view.image = R.image.coinImage()
        return view
    }()

    private let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "21:45"
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    private let minusButton : UIButton = {
        let button = UIButton()
        button.setImage(R.image.minusButtonImage(), for: .normal)
        button.isHidden = true
        return button
    }()

    private let plusButton : UIButton = {
        let button = UIButton()
        button.setImage(R.image.plusButtonImage(), for: .normal)
        button.isHidden = true
        return button
    }()

    var switchButton : UISwitch = {
        let switchButton = UISwitch()
        switchButton.onTintColor = R.color.textColorSecondary()
        return switchButton
    }()

    var widthConstraint = NSLayoutConstraint()

    var callback: (() -> Void)?

    var callBackSwitch: ((ATYTaskType?) -> ())?

    var typeTask : ATYTaskType?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
        backgroundColor = R.color.backgroundAppColor()
        switchButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        configureCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func actionButton() {
        callback?()
    }

    @objc func switchAction(button: UISwitch!) {
        if button.isOn {
            callBackSwitch?(self.typeTask)
        }
    }

    func setUp(typeTask: ATYTaskType,
               courseName: String?,
               hasSanction: Bool,
               titleLabel: String,
               firstSubtitleLabel: String,
               secondSubtitleLabel: String?,
               state: CurrentStateTask,
               userOrCourseTask: UserOrCourseTask) {

        self.typeTask = typeTask
        switchButton.isHidden = (userOrCourseTask == .user) || typeTask == .CHECKBOX
        var image : UIImage?
        var backgroundButtonColor : UIColor?

        switch state {
        case .didNotStart:
            backgroundButtonColor = R.color.backgroundButtonCard()
        case .done:
            backgroundButtonColor = R.color.succesColor()
        case .failed:
            backgroundButtonColor = R.color.failureColor()
        case .performed:
            backgroundButtonColor = R.color.textColorSecondary()
            backContentViewBorder.isHidden = false
            backContentViewBorder.layer.borderWidth = 2
            backContentViewBorder.layer.borderColor = R.color.textColorSecondary()?.cgColor
        }

        switch typeTask {
        case .CHECKBOX:
            image = R.image.checkBoxWithoutBackground()
        case .TEXT:
            image = R.image.text()
        case .TIMER:
            image = R.image.timer()
            if state == .performed {
                image = R.image.timerPause()
                timeLabel.isHidden = false
            }

//        case 3:
//            image = R.image.timerPause()
//            timeLabel.isHidden = false
        case .RITUAL:
            self.startTaskButton.setTitle("0", for: .normal)
            self.startTaskButton.setTitleColor(R.color.backgroundTextFieldsColor(), for: .normal)
            self.startTaskButton.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
            if state == .performed {
                self.plusButton.isHidden = false
                self.minusButton.isHidden = false
            }
        }

        self.sanctionImageView.isHidden = !hasSanction

        self.startTaskButton.setImage(image, for: .normal)
        self.startTaskButton.backgroundColor = backgroundButtonColor
        self.courseLabel.text = " " + (courseName ?? "") + " "
        self.titleLabel.text = titleLabel
        self.firstSubtitle.text = firstSubtitleLabel
        self.secondSubtitle.text = secondSubtitleLabel

        self.courseLabel.isHidden = courseName == nil
        self.secondSubtitle.isHidden = secondSubtitleLabel == nil
        self.dotView.isHidden = secondSubtitle.isHidden
        widthConstraint.constant = firstSubtitle.intrinsicContentSize.width
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.backContentViewBorder.layer.borderWidth = 0
        self.backContentViewBorder.layer.borderColor = UIColor.clear.cgColor
        self.timeLabel.isHidden = true
        self.minusButton.isHidden = true
        self.plusButton.isHidden = true
        self.startTaskButton.setTitle("", for: .normal)
        widthConstraint.constant = 0
    }

    private func configureCell() {
        contentView.addSubview(backContentView)
        backContentView.addSubview(backContentViewBorder)
        backContentViewBorder.layer.cornerRadius = 19
        backContentViewBorder.backgroundColor = .clear
        backContentView.layer.cornerRadius = 19
        backContentView.addSubview(startTaskButton)
        backContentView.addSubview(titleLabel)
        backContentView.addSubview(firstSubtitle)
        backContentView.addSubview(dotView)
        backContentView.addSubview(secondSubtitle)
        backContentView.addSubview(courseLabel)
        backContentView.addSubview(sanctionImageView)
        backContentView.addSubview(timeLabel)
        backContentView.addSubview(minusButton)
        backContentView.addSubview(plusButton)
        backContentView.addSubview(switchButton)

        backContentView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }

        switchButton.addTarget(self, action: #selector(switchAction), for: .valueChanged)
        switchButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(backContentView)
        }

        backContentViewBorder.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }

        startTaskButton.layer.cornerRadius = 19
        startTaskButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        startTaskButton.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        startTaskButton.backgroundColor = R.color.backgroundButtonCard()
        startTaskButton.snp.makeConstraints { (make) in
            make.leading.bottom.top.equalToSuperview()
            make.width.equalTo(backContentView.snp.width).multipliedBy(0.2)
        }

        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(startTaskButton.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }

        firstSubtitle.snp.makeConstraints { (make) in
            make.leading.equalTo(startTaskButton.snp.trailing).offset(16)
            make.bottom.equalToSuperview().offset(-11)
        }

        widthConstraint = firstSubtitle.widthAnchor.constraint(equalToConstant: firstSubtitle.intrinsicContentSize.width)
        widthConstraint.isActive = true

        dotView.layer.cornerRadius = 2
        dotView.snp.makeConstraints { (make) in
            make.leading.equalTo(firstSubtitle.snp.trailing).offset(6)
            make.centerY.equalTo(firstSubtitle)
            make.width.height.equalTo(4)
        }

        secondSubtitle.snp.makeConstraints { (make) in
            make.leading.equalTo(dotView.snp.trailing).offset(6)
            make.centerY.equalTo(dotView)
            make.trailing.equalTo(switchButton.snp.leading).offset(-10)
        }

        sanctionImageView.layer.cornerRadius = 7
        sanctionImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(backContentView.snp.top)
            make.trailing.equalToSuperview().offset(-13)
            make.width.height.equalTo(14)
        }

        courseLabel.layer.cornerRadius = 7
        courseLabel.textAlignment = .center
        courseLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(sanctionImageView.snp.leading).offset(-5)
            make.centerY.equalTo(sanctionImageView)
        }

        timeLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(backContentView.snp.trailing).offset(-16)
            make.centerY.equalTo(backContentView)
        }

        plusButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(backContentView.snp.trailing).offset(-16)
            make.centerY.equalTo(backContentView)
            make.height.width.equalTo(20)
        }

        minusButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(plusButton.snp.leading).offset(-12.5)
            make.centerY.equalTo(backContentView)
            make.height.width.equalTo(20)
        }

    }

}
