//
//  ATYSearchBarCollectionView.swift
//  AppToYou
//
//  Created by Philip Bratov on 08.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit
import SHSearchBar

class ATYSearchBarCollectionView: UIView , SHSearchBarDelegate {

    var searchBar : SHSearchBar!

    let allCoursesButton : UIButton = {
        let button = UIButton()
        button.setTitle("Все курсы", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(R.color.titleTextColor(), for: .normal)
        return button
    }()

    let myCoursesButton : UIButton = {
        let button = UIButton()
        button.setTitle("Мои курсы", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(R.color.titleTextColor(), for: .normal)
        return button
    }()

    let allCoursesViewBottom : UIView = {
        let view = UIView()
        view.backgroundColor = R.color.textColorSecondary()
        return view
    }()

    let myCoursesViewBottom : UIView = {
        let view = UIView()
        view.backgroundColor = R.color.textColorSecondary()
        return view
    }()

    let lineView : UIView = {
        let view = UIView()
        view.backgroundColor = R.color.lineViewBackgroundColor()
        return view
    }()

    var searchTextCallback: ((String?) -> ())?

    var flag = false

    var buttonConstraint  = NSLayoutConstraint()
    var collectionConstraint = NSLayoutConstraint()

    var firstCallback : (() -> ())?
    var secondCallback : (() -> ())?

    var countSelected = 0
    private var massive : [ATYCourseCategorySelect] = [ATYCourseCategorySelect(courseCategory: .CHILDREN, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .PETS, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .FOOD, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .HEALTHY_LIFESTYLE, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .FOREIGN_LANGUAGES, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .BEAUTY, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .EDUCATION, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .PERSONAL_DEVELOPMENT, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .CREATION, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .FINANCE, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .HOBBY, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .IT, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .RELATIONSHIPS, isSelected: false),
                                                             ATYCourseCategorySelect(courseCategory: .OTHER, isSelected: false)]

    var callbackErrorThree: (() -> ())?

    var collectionView : UICollectionView!

    init(flag : Bool, frame : CGRect) {
        super.init(frame: frame)
        self.flag = flag
        backgroundColor = R.color.backgroundAppColor()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ATYCollectionViewCourseCell.self, forCellWithReuseIdentifier: ATYCollectionViewCourseCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = R.color.backgroundAppColor()
        collectionView.dataSource = self
        configureOne()
        if flag {
            self.allCoursesButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            self.myCoursesButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            self.allCoursesViewBottom.isHidden = false
            self.myCoursesViewBottom.isHidden = true
            configureSecond()
        } else {
            self.myCoursesButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            self.allCoursesButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            self.allCoursesViewBottom.isHidden = true
            self.myCoursesViewBottom.isHidden = false
        }
    } 

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func firstAction() {
        firstCallback?()
    }

    @objc func secondAction() {
        secondCallback?()
    }

    private func configureOne() {
        self.addSubview(allCoursesButton)
        self.addSubview(myCoursesButton)
        self.addSubview(allCoursesViewBottom)
        self.addSubview(myCoursesViewBottom)
        self.addSubview(lineView)

        allCoursesButton.addTarget(self, action: #selector(firstAction), for: .touchUpInside)
        allCoursesButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(53)
            make.top.equalToSuperview().offset(20)
            make.width.equalToSuperview().multipliedBy(0.3)
        }

        myCoursesButton.addTarget(self, action: #selector(secondAction), for: .touchUpInside)
        myCoursesButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-53)
            make.centerY.equalTo(allCoursesButton)
            make.width.equalToSuperview().multipliedBy(0.3)
        }

        allCoursesViewBottom.layer.cornerRadius = 1
        allCoursesViewBottom.snp.makeConstraints { (make) in
            make.leading.equalTo(allCoursesButton).offset(15)
            make.trailing.equalTo(allCoursesButton).offset(-15)
            make.bottom.equalTo(allCoursesButton)
            make.height.equalTo(2)
        }

        myCoursesViewBottom.layer.cornerRadius = 1
        myCoursesViewBottom.snp.makeConstraints { (make) in
            make.leading.equalTo(myCoursesButton).offset(15)
            make.trailing.equalTo(myCoursesButton).offset(-15)
            make.bottom.equalTo(myCoursesButton)
            make.height.equalTo(2)
        }

        lineView.alpha = 0.2
        lineView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(myCoursesViewBottom).offset(1)
            make.height.equalTo(1)
        }

        self.buttonConstraint = self.myCoursesButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        self.buttonConstraint.isActive = true
        self.collectionConstraint.isActive = false
    }

    private func configureSecond() {
        let rasterSize: CGFloat = 10.0
        let leftView1 = imageViewWithIcon(R.image.searchImage()!, raster: rasterSize)

        searchBar = defaultSearchBar(withRasterSize: rasterSize,
                                      leftView: leftView1,
                                      rightView: nil,
                                      delegate: self, placeholder: "Введите текст")
        self.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(myCoursesButton.snp.bottom).offset(25)
            make.height.equalTo(47)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom).offset(5)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
        }

        self.collectionConstraint = self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        self.collectionConstraint.isActive = true
        self.buttonConstraint.isActive = false
    }
}

extension ATYSearchBarCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return massive.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ATYCollectionViewCourseCell.reuseIdentifier, for: indexPath) as! ATYCollectionViewCourseCell
        let item = massive[indexPath.row]

        cell.setUp(text: massive[indexPath.row].courseCategory.title)

        if item.isSelected {
            cell.backgroundViewCell.backgroundColor = R.color.textColorSecondary()
            cell.labelNameTypeCourse.textColor = R.color.backgroundTextFieldsColor()
        } else {
            cell.backgroundViewCell.backgroundColor = R.color.backgroundTextFieldsColor()
            cell.labelNameTypeCourse.textColor = R.color.titleTextColor()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !massive[indexPath.row].isSelected && countSelected == 3 {
            self.callbackErrorThree?()
            return
        }

        if massive[indexPath.row].isSelected {
            massive[indexPath.row].isSelected = false
            countSelected -= 1
        } else {
            massive[indexPath.row].isSelected = true
            countSelected += 1
        }

        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = massive[indexPath.item].courseCategory.title
        label.sizeToFit()
        let width = label.frame.width < 80 ? 80 : label.frame.width
        return CGSize(width: width, height: 36)
    }
}

extension  ATYSearchBarCollectionView {
    func searchBar(_ searchBar: SHSearchBar, textDidChange text: String) {
        searchTextCallback?(text)
    }
}
