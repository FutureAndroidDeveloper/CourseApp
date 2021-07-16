//
//  ATYSearchBarCollectionView.swift
//  AppToYou
//
//  Created by Philip Bratov on 08.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYSearchBarCollectionView: UIView {
    let searchBar = UISearchBar()

    let massive = ["Здоровье", "Красота", "Развитие", "Обучение", "Рост", "Спорт", "Танцы", "Бег"]

    var selectedIndex = 0

    var collectionView : UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = R.color.backgroundAppColor()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ATYCollectionViewCourseCell.self, forCellWithReuseIdentifier: ATYCollectionViewCourseCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = R.color.backgroundAppColor()
        collectionView.dataSource = self
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func configure() {
        self.addSubview(searchBar)
        searchBar.layer.borderWidth = 1
        searchBar.backgroundColor = R.color.backgroundTextFieldsColor()
        searchBar.layer.borderColor = R.color.backgroundAppColor()?.cgColor
        searchBar.barTintColor = R.color.backgroundAppColor()
        searchBar.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.height.equalTo(60)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}

extension ATYSearchBarCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return massive.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ATYCollectionViewCourseCell.reuseIdentifier, for: indexPath) as! ATYCollectionViewCourseCell
        let isSelectedCell = selectedIndex == indexPath.row
        cell.backgroundViewCell.backgroundColor = isSelectedCell ? R.color.textColorSecondary() : R.color.backgroundTextFieldsColor()

        cell.labelNameTypeCourse.textColor = isSelectedCell ? R.color.backgroundTextFieldsColor() : R.color.titleTextColor()

        cell.setUp(text: massive[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        self.collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 36)
    }
}
