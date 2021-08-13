//
//  ATYCategoryCourseCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 14.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYCategoryCourseCell: UITableViewCell {

    var massive = [ATYCourseCategory]()

    var collectionView : UICollectionView!

    var nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Категория курса"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let nameTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Выберите из списка"
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
        textField.textColor = R.color.titleTextColor()
        return textField
    }()

    var callBack: (() -> ())?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
        configure()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ATYCollectionViewCourseCell.self, forCellWithReuseIdentifier: ATYCollectionViewCourseCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = R.color.backgroundAppColor()
        collectionView.dataSource = self
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-15)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameTextField)

        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        nameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0.0)
        nameTextField.layer.cornerRadius = 22

        let arrowImageView =  UIImageView(frame: CGRect(x: 0, y: 20, width: 8, height: 4))
        arrowImageView.image = R.image.downArrowTf()

        let arrowView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        arrowView.addSubview(arrowImageView)
        nameTextField.rightView = arrowView
        nameTextField.delegate = self
        nameTextField.rightViewMode = .always
        nameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
    }
}

extension ATYCategoryCourseCell : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        nameTextField.resignFirstResponder()
        self.callBack?()
    }
}

extension ATYCategoryCourseCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return massive.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ATYCollectionViewCourseCell.reuseIdentifier, for: indexPath) as! ATYCollectionViewCourseCell
        cell.backgroundViewCell.backgroundColor = R.color.backgroundTextFieldsColor()
        cell.backgroundViewCell.layer.borderWidth = 1
        cell.backgroundViewCell.layer.borderColor = R.color.borderColor()?.cgColor

        cell.labelNameTypeCourse.textColor =  R.color.textSecondaryColor()

        cell.setUp(text: massive[indexPath.row].title)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = massive[indexPath.item].title
                label.sizeToFit()
        let width = label.frame.width < 80 ? 80 : label.frame.width
        return CGSize(width: width, height: 36)
    }
}
