//
//  InstantPanGestureRecognizer.swift
//  AppToYou
//
//  Created by Philip Bratov on 26.05.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class InstantPanGestureRecognizer: UIPanGestureRecognizer {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == .began) { return }
        super.touchesBegan(touches, with: event)
        self.state = .began
    }
}
