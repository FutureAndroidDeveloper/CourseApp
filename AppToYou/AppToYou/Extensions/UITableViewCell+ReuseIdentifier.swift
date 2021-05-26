//
//  UITableViewCell+ReuseIdentifier.swift
//  AppToYou
//
//  Created by Philip Bratov on 26.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

public extension UITableViewCell {
    class var reuseIdentifier: String { return String(describing: self)}
}
