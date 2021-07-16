//
//  UIViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 02.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

extension UIViewController {
    open func showAlert() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = view.bounds

        let attributedString = NSAttributedString(string: "Хотите выйти без сохранения изменений?", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), //your font here
            NSAttributedString.Key.foregroundColor : R.color.titleTextColor() ?? .black
        ])

        let alertController = UIAlertController.init(title: "", message: "", preferredStyle: .alert)

        alertController.setValue(attributedString, forKey: "attributedTitle")

        alertController.view.tintColor = R.color.buttonColor()

        alertController.addAction(UIAlertAction(title: "Выйти", style: .default, handler: { [weak self] (action: UIAlertAction!) in
            blurVisualEffectView.removeFromSuperview()
            self?.navigationController?.popViewController(animated: true)
        }))

        alertController.addAction(UIAlertAction(title: "Сохранить", style: .default, handler: { [weak self] (action: UIAlertAction!) in
            blurVisualEffectView.removeFromSuperview()
            self?.navigationController?.popViewController(animated: true)
        }))
        self.view.addSubview(blurVisualEffectView)
        self.present(alertController, animated: true, completion: nil)
    }

    open func showAlertCountSelectedCourseCategory() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = view.bounds

        let attributedString = NSAttributedString(string: "Курс может иметь не более трех категорий!", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), //your font here
            NSAttributedString.Key.foregroundColor : R.color.titleTextColor() ?? .black
        ])

        let alertController = UIAlertController.init(title: "", message: "", preferredStyle: .alert)

        alertController.setValue(attributedString, forKey: "attributedTitle")

        alertController.view.tintColor = R.color.buttonColor()

        alertController.addAction(UIAlertAction(title: "Понятно", style: .default, handler: {(action: UIAlertAction!) in
            blurVisualEffectView.removeFromSuperview()
        }))
        self.view.addSubview(blurVisualEffectView)
        self.present(alertController, animated: true, completion: nil)
    }
}
