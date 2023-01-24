//
//  ATYNavigationBarWalletViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 04.08.2021.
//  Copyright © 2021 .... All rights reserved.
//

import Parchment
import UIKit

class ATYNavigationBarWalletViewController: UIViewController {

    var pagingViewController = PagingViewController()

    //MARK:- Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavBar()

        let viewControllers = [
            ATYWalletShopViewController(name: "Магазин"),
            ATYWalletPaymentsViewController(name: "Выплаты"),
            ATYWalletHistoryViewController(name: "История")
        ]

        pagingViewController = PagingViewController(viewControllers: viewControllers)

        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        view.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
    }

    //MARK:- Configure UI

    private func configureNavBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = R.color.lineViewBackgroundColor()
        view.backgroundColor = R.color.backgroundAppColor()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.setBackgroundImage(nil, for:.default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = false
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController?.navigationBar.barTintColor = R.color.backgroundTextFieldsColor()
        self.navigationItem.title = "Мой кошелек"
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationItem.titleView?.frame = CGRect(origin: .zero, size: navigationBar.bounds.size)
        pagingViewController.borderOptions = .hidden
        pagingViewController.menuBackgroundColor = R.color.backgroundTextFieldsColor() ?? .gray
        pagingViewController.indicatorColor = R.color.textColorSecondary() ?? .orange
        pagingViewController.textColor = R.color.textSecondaryColor() ?? .gray
        pagingViewController.selectedTextColor = R.color.titleTextColor() ?? .orange
        pagingViewController.menuHorizontalAlignment = .center
        pagingViewController.menuItemSpacing = 22
        pagingViewController.indicatorOptions = .visible(height: 2, zIndex: 10, spacing: UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1), insets: UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1))
        pagingViewController.menuItemSize = .selfSizing(estimatedWidth: 100, height: navigationBar.bounds.height)
    }

}
