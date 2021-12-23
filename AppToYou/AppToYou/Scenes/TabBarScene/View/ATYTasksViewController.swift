//
//  ATYTabBarController.swift
//  AppToYou
//
//  Created by Philip Bratov on 25.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Parchment
import UIKit
import XCoordinator

class NavigationBarViewController: UIViewController {
    
    private let taskRouter: UnownedRouter<TasksRoute>
    
    private lazy var pagingViewController: NavigationBarPagingViewController = {
        let viewController = NavigationBarPagingViewController(viewControllers: [
            ToodayTaskViewController(title: R.string.localizable.today(), taskRouter: self.taskRouter),
//            ATYTodayTasksViewController(title: R.string.localizable.today(), taskRouter: self.taskRouter),
            ATYAllTasksViewController(name: R.string.localizable.allTasks())
        ])
        return viewController
    }()
    
//    let pagingViewController = NavigationBarPagingViewController(viewControllers: [
//        ATYTodayTasksViewController(title: R.string.localizable.today(), taskRouter: self.taskRouter),
//        ATYAllTasksViewController(name: R.string.localizable.allTasks())
//    ])
//
    init(taskRouter: UnownedRouter<TasksRoute>) {
        self.taskRouter = taskRouter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageView()
        navigationController?.navigationBar.installBlurEffect()
    }

    func addBlurEffect() {
        let bounds = self.navigationController?.navigationBar.bounds
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.alpha = 0.1
        visualEffectView.frame = bounds ?? CGRect.zero
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.navigationController?.navigationBar.addSubview(visualEffectView)
        self.navigationController?.navigationBar.sendSubviewToBack(visualEffectView)

        // Here you can add visual effects to any UIView control.
        // Replace custom view with navigation bar in the above code to add effects to the custom view.
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
        pagingViewController.contentInteraction = .none
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
