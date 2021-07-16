//
//  ATYSearchBarCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 04.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYSearchBarCell : UITableViewCell {
    let searchBar = UISearchBar()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        self.selectionStyle = .none
        backgroundColor = R.color.backgroundAppColor()
        contentView.backgroundColor = R.color.backgroundAppColor()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(searchBar)
        searchBar.layer.borderWidth = 1
        searchBar.backgroundColor = R.color.backgroundTextFieldsColor()
        searchBar.delegate = self
        searchBar.layer.borderColor = R.color.backgroundAppColor()?.cgColor
        searchBar.barTintColor = R.color.backgroundAppColor()
        searchBar.snp.makeConstraints { (make) in
            make.height.equalTo(60)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.top.equalToSuperview()
        }
    }
}


extension ATYSearchBarCell: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
}
