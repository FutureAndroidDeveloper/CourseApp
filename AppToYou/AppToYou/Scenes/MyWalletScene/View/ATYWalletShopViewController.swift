//
//  ATYWalletShopViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 04.08.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

struct WalletCoint {
    let image : UIImage?
    let howMuchMoney : Int
    let howMuchCost : Double
    var isHiddenNewLabel: Bool = true
}

class ATYWalletShopViewController : UIViewController {

    let yourBalanceView = ATYYourBalanceView()

    var collectionView : UICollectionView!

    let arrayWallet = [WalletCoint(image: R.image.tenMoney(), howMuchMoney: 10, howMuchCost: 0.99),
                       WalletCoint(image: R.image.fiftyMoney(), howMuchMoney: 50, howMuchCost: 2.00),
                       WalletCoint(image: R.image.oneHungredMoney(), howMuchMoney: 100, howMuchCost: 10.00),
                       WalletCoint(image: R.image.threeHungredMoney(), howMuchMoney: 300, howMuchCost: 15.00, isHiddenNewLabel: false)]

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    convenience init(name: String) {
        self.init(title: name)
    }

    convenience init(title: String) {
        self.init(titles: title)
    }

    init(titles: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = titles
        view.backgroundColor = R.color.backgroundAppColor()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        view.addSubview(yourBalanceView)
        yourBalanceView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(50)
        }

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "ATYShopCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ATYShopCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = R.color.backgroundAppColor()
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(yourBalanceView.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
}

extension ATYWalletShopViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayWallet.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ATYShopCollectionViewCell.reuseIdentifier, for: indexPath) as! ATYShopCollectionViewCell
        let item = arrayWallet[indexPath.row]
        cell.setUp(howMuchCost: item.howMuchCost, howMuchMoney: item.howMuchMoney, coinImageView: item.image, isHiddenNewLabel: item.isHiddenNewLabel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
        let frameCV = collectionView.frame
        let cellWidth = frameCV.width / CGFloat(4.4)

        return CGSize(width: cellWidth, height: cellWidth * 1.21)

       }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
