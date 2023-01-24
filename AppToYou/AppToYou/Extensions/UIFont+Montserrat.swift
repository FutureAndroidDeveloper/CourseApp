//
//  UIFont+Montserrat.swift
//  AppToYou
//
//  Created by Philip Bratov on 24.05.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

extension UIFont {

    static func Regular(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
}

enum CurrentStateTask : Int {
    case performed // orange
    case didNotStart // gray
    case done // green
    case failed // red
}
