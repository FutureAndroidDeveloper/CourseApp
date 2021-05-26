//
//  ATYNavigationViewController+PageView.swift
//  AppToYou
//
//  Created by Philip Bratov on 25.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation
import Parchment

// Create our own custom paging view and override the layout
// constraints. The default implementation positions the menu view
// above the page view controller, but since we're going to put the
// menu view inside the navigation bar we don't want to setup any
// layout constraints for the menu view.
class NavigationBarPagingView: PagingView {
    override func setupConstraints() {
        // Use our convenience extension to constrain the page view to all
        // of the edges of the super view.
        constrainToEdges(pageView)
    }
}

// Create a custom paging view controller and override the view with
// our own custom subclass.
class NavigationBarPagingViewController: PagingViewController {
    override func loadView() {
        view = NavigationBarPagingView(
            options: options,
            collectionView: collectionView,
            pageView: pageViewController.view
        )
    }
}
