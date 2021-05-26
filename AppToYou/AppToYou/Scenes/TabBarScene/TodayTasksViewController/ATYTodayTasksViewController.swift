//
//  ATYTodayTasksViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 25.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation
import UIKit

final class ATYTodayTasksViewController: UIViewController {

    private var transition: PanelTransition!

    var calendarCollectionView: UICollectionView!
    var calendarCollectionViewController: ATYCalendarCollectionViewController!
    let typeButton = UIButton()
    let tipImageView = UIImageView()
    let progressView = ATYStackProgressView()
    var panGesture = UITapGestureRecognizer()

    convenience init(name: String) {
        self.init(title: name)
    }

    convenience init(title: String) {
        self.init(title: title, content: title)
    }

    init(title: String, content: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.title = title

        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 50, weight: UIFont.Weight.thin)
        label.textColor = UIColor(red: 95 / 255, green: 102 / 255, blue: 108 / 255, alpha: 1)
        label.textAlignment = .center
        label.text = content
        label.sizeToFit()

        view.addSubview(label)
        view.constrainToEdges(label)
        view.backgroundColor = R.color.backgroundAppColor()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.transition = PanelTransition(y: view.bounds.height * 0.4 , height: view.bounds.height * 0.6)
        self.panGesture = UITapGestureRecognizer(target: self, action: #selector(tapForImageViewAction))
        view.addGestureRecognizer(panGesture)
        configureAddButtonAndTipImage()
        configureViewControllers()
        confgigureStackView()
    }

    @objc func tapForImageViewAction() {
        let color = (progressView.countOfViews?.count ?? 0) % 2 == 0 ? R.color.succesColor() : R.color.failureColor()
        progressView.countOfViews = (count: (progressView.countOfViews?.count ?? 0) + 1, color: color ?? .green)
        print(progressView.countOfViews?.count ?? 0)
        progressView.layoutSubviews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.calendarCollectionViewController.updateData()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.typeButton.layer.cornerRadius = self.typeButton.frame.height/2
        typeButton.layer.masksToBounds = false
        typeButton.layer.shadowColor = UIColor.black.cgColor
        typeButton.layer.shadowPath = UIBezierPath(roundedRect: typeButton.bounds, cornerRadius: typeButton.layer.cornerRadius).cgPath
        typeButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        typeButton.layer.shadowOpacity = 0.5
        typeButton.layer.shadowRadius = 1.0
    }

    private func configureAddButtonAndTipImage() {
        let icon = R.image.vBth_add()?.withRenderingMode(.alwaysTemplate)
        self.typeButton.setImage(icon, for: .normal)
        self.typeButton.tintColor = R.color.backgroundTextFieldsColor()
        self.typeButton.backgroundColor = R.color.buttonColor()
        self.typeButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)

        view.addSubview(self.typeButton)
        self.typeButton.snp.makeConstraints { (make) in
            make.bottom.trailing.equalToSuperview().offset(-25)
            make.height.width.equalTo(50)
        }

        tipImageView.image = R.image.tip()
        view.addSubview(tipImageView)

        self.tipImageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(typeButton.snp.leading).offset(-10)
            make.centerY.equalTo(typeButton)
        }
    }

    private func configureViewControllers() {
        self.calendarCollectionViewController = ATYCalendarCollectionViewController()
        self.calendarCollectionView = self.calendarCollectionViewController.collectionView

        view.addSubview(self.calendarCollectionView)
        addChild(self.calendarCollectionViewController)
        self.calendarCollectionViewController.didMove(toParent: self)


        self.calendarCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.height.equalTo(100)
        }
    }

    private func confgigureStackView() {
        view.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(calendarCollectionView.snp.bottom)
            make.height.equalTo(3)
        }
    }

    //MARK:- Handlers

    @objc func addButtonAction() {
        let child = ATYAddTaskViewController()
        child.transitioningDelegate = transition   // 2
        child.modalPresentationStyle = .custom  // 3

        present(child, animated: true)
    }
}

