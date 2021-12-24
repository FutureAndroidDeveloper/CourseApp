//
//  ATYImagePicker.swift
//  AppToYou
//
//  Created by Philip Bratov on 24.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

public protocol ATYImagePickerDelegate: class {
    func didSelect(image: UIImage?, withPath path: String?)
    func deleteCurrentImage()
    func showCurrentImage()
}

open class ATYImagePicker: NSObject {

    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ATYImagePickerDelegate?

    public init(presentationController: UIViewController, delegate: ATYImagePickerDelegate) {
        self.pickerController = UIImagePickerController()

        super.init()

        self.presentationController = presentationController
        self.delegate = delegate

        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
    }

    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        return UIAlertAction(title: title, style: .default) { [weak self] _ in
            guard let self = self else { return }
            if UIImagePickerController.isSourceTypeAvailable(type) {
                self.pickerController.sourceType = type
                self.presentationController?.present(self.pickerController, animated: true)
            }
            else
            {
                let alert  = UIAlertController(title:"Нет доступа", message: "Нет доступа к галерее", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                alert.addAction(UIAlertAction(title: "Настройки", style: .default, handler: { _ in
                    guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
                        assertionFailure("UIApplication.openSettingsURLString not exist")
                        return
                    }
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }))
                self.presentationController?.present(alert, animated: true, completion: nil)
            }
        }
    }

    public func present() {

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = R.color.backgroundAppColor()
        alertController.view.tintColor = R.color.buttonColor()

        let action = UIAlertAction(title: "Просмотреть", style: .default, handler: { _ in
            self.delegate?.showCurrentImage()
        })
        action.setValue(R.image.vIc_vision(), forKey: "image")
        alertController.addAction(action)

        if let action = self.action(for: .camera, title: "Сделать фото") {
            action.setValue(R.image.vIc_takePhoto(), forKey: "image")
            alertController.addAction(action)
        }

        if let action = self.action(for: .photoLibrary, title: "Загрузить из галлереи") {
            action.setValue(R.image.vIc_gallery(), forKey: "image")
            alertController.addAction(action)
        }
        let actionRemove = UIAlertAction(title: "Удалить фото", style: .destructive, handler: { _ in
            self.delegate?.deleteCurrentImage()
        })
        actionRemove.setValue(R.image.vIc_trash(), forKey: "image")
        alertController.addAction(actionRemove)


        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(actionCancel)

        //        if let cancelBackgroundViewType = NSClassFromString("_UIAlertControlleriOSActionSheetCancelBackgroundView") as? UIView.Type {
        //         //   cancelBackgroundViewType.appearance().subviewsBackgroundColor = STMTheme.current.backgroundTableColor
        //        }

        self.presentationController?.present(alertController, animated: true)
    }

    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?, withPath path: String? = nil) {
        controller.dismiss(animated: true, completion: nil)
        self.delegate?.didSelect(image: image, withPath: path)
    }
}

extension ATYImagePicker: UIImagePickerControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        guard let image = info[.editedImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }

        guard let docDir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {
            print("Couldn't get document directory for file")
            return
        }
        let imageUniqueName : Int64 = Int64(NSDate().timeIntervalSince1970 * 1000);
        let filePath = docDir.appendingPathComponent("\(imageUniqueName).jpg");

        do{
            if let pngImageData = (info[UIImagePickerController.InfoKey.editedImage] as? UIImage)!.jpegData(compressionQuality: 0.25) {
                try pngImageData.write(to : filePath , options : .atomic)
            }
        } catch{
            print("Couldn't write image")
        }
        self.pickerController(picker, didSelect: image, withPath: "\(imageUniqueName).jpg")
    }
}

extension ATYImagePicker: UINavigationControllerDelegate {}
