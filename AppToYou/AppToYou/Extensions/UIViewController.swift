//
//  UIViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 02.06.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit
import Toast_Swift

extension UIViewController {

    struct Holder {
        static var _blurVisualEffectView: UIVisualEffectView?
        static var _view: UIView?
        static var _button: UIButton?
    }

    var blurVisualEffectView:UIVisualEffectView {
        get {
            return Holder._blurVisualEffectView ?? UIVisualEffectView()
        }
        set(newValue) {
            Holder._blurVisualEffectView = newValue
        }
    }

    var popupView : UIView {
        get {
            return Holder._view ?? UIView()
        }
        set(newValue) {
            Holder._view = newValue
        }
    }

    var buttonSome : UIButton {
        get {
            return Holder._button ?? UIButton()
        }
        set(newValue) {
            Holder._button = newValue
        }
    }

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

    open func showAlertCountSelectedCourseCategory(text: String) {
        let blurEffect = UIBlurEffect(style: .light)
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = view.bounds

        let attributedString = NSAttributedString(string: text, attributes: [
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

    open func showViewBlur() {
        let blurEffect = UIBlurEffect(style: .light)
        self.blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = view.bounds
        self.view.addSubview(blurVisualEffectView)

        popupView = UIView()
        popupView.backgroundColor = R.color.backgroundTextFieldsColor()
        self.view.addSubview(popupView)

        popupView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(150)
        }

         buttonSome = UIButton()
        buttonSome.setTitle("Close", for: .normal)
        buttonSome.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        buttonSome.backgroundColor = .red

        popupView.addSubview(buttonSome)
        buttonSome.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(50)
        }
    }

    @objc func buttonAction() {
        self.blurVisualEffectView.removeFromSuperview()
        self.popupView.removeFromSuperview()
    }


    func showToast(textMessage: String) {
        var style = ToastStyle()
        style.messageFont = UIFont.systemFont(ofSize: 14)
        style.messageColor = R.color.titleTextColor() ?? .black
        style.messageAlignment = .center
        style.shadowColor = .black
        style.displayShadow = true
        style.cornerRadius = 20
        style.backgroundColor = R.color.backgroundTextFieldsColor() ?? .white
        self.navigationController?.view.makeToast(textMessage, duration: 2.0, position: .bottom, style: style)
    }
}
