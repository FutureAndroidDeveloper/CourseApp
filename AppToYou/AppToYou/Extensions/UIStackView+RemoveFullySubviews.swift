//
//  UIStackView+RemoveFullySubviews.swift
//  AppToYou
//
//  Created by Philip Bratov on 03.06.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

extension UIStackView {

    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }

    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { (view) in
            removeFully(view: view)
        }
    }

}
