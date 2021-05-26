//
//  ATYTabBarController.swift
//  AppToYou
//
//  Created by Philip Bratov on 25.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Parchment
import UIKit

class NavigationBarViewController: UIViewController {
    let pagingViewController = NavigationBarPagingViewController(viewControllers: [
        ATYTodayTasksViewController(name: "Сегодня"),
        ATYAllTasksViewController(name: "Все задачи")
    ])

    //MARK:- Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageView()
       
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationItem.titleView?.frame = CGRect(origin: .zero, size: navigationBar.bounds.size)
        pagingViewController.menuItemSize = .selfSizing(estimatedWidth: 100, height: navigationBar.bounds.height)
    }

    //MARK:- Configure UI

    private func configurePageView() {
        pagingViewController.borderOptions = .hidden
        pagingViewController.menuBackgroundColor = .clear
        pagingViewController.indicatorColor = R.color.textColorSecondary() ?? .orange
        pagingViewController.textColor = R.color.textSecondaryColor() ?? .gray
        pagingViewController.selectedTextColor = R.color.titleTextColor() ?? .orange
        pagingViewController.menuItemSpacing = 70
        pagingViewController.menuHorizontalAlignment = .center
        pagingViewController.indicatorOptions = .visible(height: 2, zIndex: 10, spacing: UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1), insets: UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1))

        // Make sure you add the PagingViewController as a child view
        // controller and contrain it to the edges of the view.
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        view.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParent: self)

        // Set the menu view as the title view on the navigation bar. This
        // will remove the menu view from the view hierachy and put it
        // into the navigation bar.
        navigationItem.titleView = pagingViewController.collectionView
    }
}

