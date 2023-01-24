//
//  PanelTransition.swift
//  AppToYou
//
//  Created by Philip Bratov on 26.05.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class PanelTransition: NSObject, UIViewControllerTransitioningDelegate {

    // MARK: - Presentation controller
    var y: CGFloat = 0
    var height: CGFloat = 0

    init(y: CGFloat, height: CGFloat) {
        super.init()
        self.y = y
        self.height = height
    }
    private let driver = TransitionDriver()

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        driver.link(to: presented)

        let presentationController = DimmPresentationController(presentedViewController: presented,
                                                                presenting: presenting ?? source, y: self.y, height: self.height)
        presentationController.driver = driver
        return presentationController
    }

    // MARK: - Animation
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation()
    }

    // MARK: - Interaction
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return driver
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return driver
    }
}
