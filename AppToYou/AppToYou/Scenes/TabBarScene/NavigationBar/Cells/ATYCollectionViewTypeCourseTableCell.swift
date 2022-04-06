//
//  ATYCollectionViewTypeCourseCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 04.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

@available(*, deprecated, message: "old version")
class ATYCollectionViewTypeCourseTableCell : UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let massive = ["Здоровье", "Красота", "Развитие", "Обучение", "Рост", "Спорт", "Танцы", "Бег"]

    var selectedIndex = 0

    var collectionView : UICollectionView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        backgroundColor = R.color.backgroundAppColor()
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
            make.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        let label = UILabel(frame: CGRect.zero)
        label.text = massive[indexPath.item]
        label.sizeToFit()
        let width = label.frame.width < 80 ? 80 : label.frame.width
        return CGSize(width: width, height: 36)
    }
}
