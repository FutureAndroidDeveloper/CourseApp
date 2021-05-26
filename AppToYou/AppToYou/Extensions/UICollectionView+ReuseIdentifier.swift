//
//  UICollectionView+ReuseIdentifier.swift
//  AppToYou
//
//  Created by Philip Bratov on 25.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

public extension UICollectionViewCell {
    class var reuseIdentifier: String { return String(describing: self)}
}
