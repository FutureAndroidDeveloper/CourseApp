//
//  ATYProfileSignInCollectionAchievementCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 29.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYProfileSignInCollectionAchievementCell : UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let achievementLabel : UILabel = {
        let label = UILabel()
        label.text = "Достижения"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    let showMoreLabel : UILabel = {
        let label = UILabel()
        label.text = "Смотреть все"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    let shareImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.showMoreIcon()
        return imageView
    }()

    let massive = [("Марафонец", R.image.maniakPng()),
                   ("Маньяк", R.image.maniakPng()),
                   ("Боец", R.image.maniakPng()),
                   ("Лучший друг", R.image.maniakPng()),
                   ("Максималист", R.image.maniakPng()),
                   ("Непобедимый", R.image.maniakPng()),
                   ("Псих", R.image.maniakPng()),
                   ("Новичок", R.image.maniakPng())]

    var selectedIndex = 0

    var collectionView : UICollectionView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        backgroundColor = R.color.backgroundTextFieldsColor()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ATYCollectionAchievementCell.self, forCellWithReuseIdentifier: ATYCollectionAchievementCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = R.color.backgroundTextFieldsColor()
        collectionView.dataSource = self
        contentView.addSubview(collectionView)
        contentView.addSubview(achievementLabel)
        contentView.addSubview(showMoreLabel)
        contentView.addSubview(shareImageView)

        shareImageView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(26)
            make.height.width.equalTo(14)
        }

        showMoreLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(shareImageView.snp.leading).offset(-4)
            make.centerY.equalTo(shareImageView)
        }

        achievementLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(showMoreLabel.snp.leading).offset(-5)
            make.centerY.equalTo(shareImageView)
        }

        collectionView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(achievementLabel.snp.bottom).offset(15)
            make.bottom.equalToSuperview()
            make.height.equalTo(127)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return massive.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ATYCollectionAchievementCell.reuseIdentifier, for: indexPath) as! ATYCollectionAchievementCell
        let item = massive[indexPath.row]
//        let color = indexPath.row % 2 == 0 ? R.color.cardsColor() : R.color.succesColor()
//        let image = item.1?.withTintColor(color ?? .red)
        cell.setUp(image: item.1, text: item.0)
        cell.achiemenentImageView.tintColor = .red
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        self.collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let label = UILabel(frame: CGRect.zero)
//        label.text = massive[indexPath.item]
//        label.sizeToFit()
//        let width = label.frame.width < 80 ? 80 : label.frame.width
        return CGSize(width: 101, height: 127)
    }
}
