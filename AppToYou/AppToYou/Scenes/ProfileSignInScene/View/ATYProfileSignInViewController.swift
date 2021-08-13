//
//  ATYProfileSignInViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 29.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit
import Toast_Swift
import PopupDialog

class ATYProfileSignInViewController: UIViewController {

    private var transitionThird: PanelTransition!
    private var imagePicker: ATYImagePicker?
    private var photoImage = R.image.courseParticipantImage()

    private enum ProfileCells: Int , CaseIterable {
        case statistics
        case takeGiftPopup
        case achievement
        case needHelp
        case aboutApp
        case buttons
    }

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        view.backgroundColor = R.color.backgroundTextFieldsColor()

        self.transitionThird = PanelTransition(y: view.bounds.height * 0.6 , height: view.bounds.height * 0.4)
        self.imagePicker = ATYImagePicker(presentationController: self, delegate: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = R.color.backgroundAppColor()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        let settingsButton = UIBarButtonItem(image: R.image.settingsColorImage(), style: .plain, target: self, action: #selector(settingsAction))

        let walletButton = UIBarButtonItem(image: R.image.walletImage(), style: .plain, target: self, action: #selector(walletAction))
        navigationItem.leftBarButtonItems = [settingsButton, walletButton]
    }

    @objc func settingsAction() {
        let vc = ATYSettingsViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func walletAction() {
        let vc = ATYNavigationBarWalletViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func configureTableView() {
        view.addSubview(tableView)

        tableView.separatorStyle = .none
        tableView.backgroundColor = R.color.backgroundAppColor()
        tableView.register(ATYProfileSignInCollectionAchievementCell.self, forCellReuseIdentifier: ATYProfileSignInCollectionAchievementCell.reuseIdentifier)
        tableView.register(ATYProfileNeedHelpCell.self, forCellReuseIdentifier: ATYProfileNeedHelpCell.reuseIdentifier)
        tableView.register(ATYAboutAppCell.self, forCellReuseIdentifier: ATYAboutAppCell.reuseIdentifier)
        tableView.register(ATYProfileSignInButtonsCell.self, forCellReuseIdentifier: ATYProfileSignInButtonsCell.reuseIdentifier)
        tableView.register(UINib(nibName: "ATYProfileSignInCell", bundle: nil), forCellReuseIdentifier: ATYProfileSignInCell.reuseIdentifier)
        tableView.register(UINib(nibName: "ATYYourAccBlockedCell", bundle: nil), forCellReuseIdentifier: ATYYourAccBlockedCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    private func showToast(controller: UIViewController, color : UIColor?) {
        // Create the dialog
        let popup = PopupDialog(viewController: controller,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                tapGestureDismissal: true,
                                panGestureDismissal: true,
                                popupBackgroud: color)

        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
}

extension ATYProfileSignInViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileCells.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ProfileCells.init(rawValue: indexPath.row) {
        case .statistics:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYProfileSignInCell.reuseIdentifier, for: indexPath) as! ATYProfileSignInCell
            cell.photoImage.image = self.photoImage
            cell.photoCallback = { [weak self] in
                self?.imagePicker?.present()
            }
            return cell
        case .takeGiftPopup:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYYourAccBlockedCell.reuseIdentifier, for: indexPath) as! ATYYourAccBlockedCell
            cell.paySanctionAction = { [weak self] in
                let vc = ATYNavigationBarWalletViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        case .achievement:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYProfileSignInCollectionAchievementCell.reuseIdentifier, for: indexPath) as! ATYProfileSignInCollectionAchievementCell
            return cell
        case .needHelp:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYProfileNeedHelpCell.reuseIdentifier, for: indexPath) as! ATYProfileNeedHelpCell
            return cell
        case .aboutApp:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYAboutAppCell.reuseIdentifier, for: indexPath) as! ATYAboutAppCell
            cell.cardView.secondCallback = { [weak self] in
                let ratingVC = ATYTakeGiftViewController(nibName: "ATYTakeGiftViewController", bundle: nil)
                self?.showToast(controller: ratingVC, color: R.color.blueColor())
            }

            cell.cardView.thirdCallback = { [weak self] in
                let ratingVC = ATYReceivingAnAwardViewController(nibName: "ATYReceivingAnAwardViewController", bundle: nil)
                self?.showToast(controller: ratingVC, color: R.color.backgroundTextFieldsColor())
            }
            return cell
        case .buttons:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYProfileSignInButtonsCell.reuseIdentifier, for: indexPath) as! ATYProfileSignInButtonsCell
            cell.takeVacationCallback = { [weak self] in
                let child = ATYVacataionViewController()
                child.dismissCallback = { [weak self] in
                    self?.showToast(textMessage: "Мы будем скучать!")
                }

                child.transitioningDelegate = self?.transitionThird
                child.modalPresentationStyle = .custom
                self?.present(child, animated: true)
            }

            cell.logOutCallback = { [weak self] in

            }
            return cell
        default : return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = (tableView.cellForRow(at: indexPath) as? ATYProfileSignInCollectionAchievementCell) {
            let vc = ATYAchievementListViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ATYProfileSignInViewController: ATYImagePickerDelegate {
    func deleteCurrentImage() {
        self.photoImage = nil
        tableView.reloadData()
    }

    func showCurrentImage() {
        if let image = self.photoImage {
            let presentingViewController = ATYDetailImageViewController(image: image)
            present(presentingViewController, animated: true)
        }
    }

    func didSelect(image: UIImage?, withPath path: String?) {
        if let newImage = image {
            self.photoImage = newImage
            tableView.reloadData()
        }
    }
}
