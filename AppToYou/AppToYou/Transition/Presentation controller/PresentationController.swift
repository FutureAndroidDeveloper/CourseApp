//
//  PresentationController.swift
//  AppToYou
//
//  Created by Philip Bratov on 26.05.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController {

    var y : CGFloat = 0
    var height : CGFloat = 0

    override var shouldPresentInFullscreen: Bool {
        return false
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = containerView!.bounds
        return CGRect(x: 0,
                      y: self.y,
                      width: bounds.width,
                      height: self.height)
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()

        containerView?.addSubview(presentedView!)

    }

    init(presentedViewController: UIViewController, presenting: UIViewController?, y : CGFloat, height: CGFloat) {
        super.init(presentedViewController: presentedViewController, presenting: presenting)
        self.y = y
        self.height = height
    }


    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()

        presentedView?.frame = frameOfPresentedViewInContainerView
    }

    var driver: TransitionDriver!
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)

        if completed {
            driver.direction = .dismiss
        }
    }
}

