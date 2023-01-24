//
//  UITableView+Placeholder.swift
//  AppToYou
//
//  Created by Philip Bratov on 12.08.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

extension UITableView {
    func setNoDataPlaceholder(_ message: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        label.text = message
        label.textAlignment = .center
        label.textColor = R.color.textSecondaryColor()
        label.sizeToFit()
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        self.backgroundView = view
        
        self.isScrollEnabled = false
        self.separatorStyle = .none
        self.backgroundView?.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(100)
        }
    }

    func removeNoDataPlaceholder() {
        self.isScrollEnabled = true
        self.backgroundView = nil
    }
}
