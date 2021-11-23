//
//  ATYAddPhotoViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 24.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYAddPhotoViewController: UIViewController, BindableType {
    
    var viewModel: AddPhotoViewModel!
    
    func bindViewModel() {
        //
    }

    private var imagePicker: ATYImagePicker?

    private var image : UIImage?

    let downloadPhotoLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font =  UIFont.Regular(size: 28)
        label.text = R.string.localizable.downloadPhoto()
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let photoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = R.image.photoSmile()
        return imageView
    }()

    let addPhotoButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.backgroundTextFieldsColor()
        button.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        button.setTitleColor(R.color.textColorSecondary(), for: .normal)
        button.setTitle(R.string.localizable.yourDownloadPhoto(), for: .normal)
        return button
    }()

    let saveButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        button.setTitle(R.string.localizable.save(), for: .normal)
        return button
    }()

    let downloadAfterButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(downloadAfterButtonAction), for: .touchUpInside)
        button.setTitle(R.string.localizable.uploadPhotLater(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(R.color.buttonColor(), for: .normal)
        return button
    }()

    //MARK:- Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        self.imagePicker = ATYImagePicker(presentationController: self, delegate: self)
        view.backgroundColor = R.color.backgroundAppColor()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.height / 2
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
        photoImageView.layer.cornerRadius = photoImageView.frame.height / 2
    }

    //MARK:- Configure UI

    private func configureViews() {
        view.addSubview(downloadPhotoLabel)
        downloadPhotoLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.6)
        }

        view.addSubview(addPhotoButton)
        addPhotoButton.snp.makeConstraints { (make) in
            make.top.equalTo(downloadPhotoLabel.snp.bottom).offset(130)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        addPhotoButton.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(addPhotoButton.snp.top).offset(10)
            make.width.height.equalTo(100)
        }

        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { (make) in
            make.top.equalTo(addPhotoButton.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        view.addSubview(downloadAfterButton)
        downloadAfterButton.snp.makeConstraints { (make) in
            make.top.equalTo(saveButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(18)
        }
        
    }

    //MARK:- Handlers

    @objc func doneButtonAction() {
        self.imagePicker?.present()
    }

    @objc func saveButtonAction() {
        // upload photo
//        tabBarConfigure()
        
    }

    @objc func downloadAfterButtonAction() {
//        tabBarConfigure()
    }
    
}

extension ATYAddPhotoViewController: ATYImagePickerDelegate {
    func deleteCurrentImage() {
        self.image = nil
        photoImageView.image = R.image.photoSmile()
    }

    func showCurrentImage() {
        if let image = self.image {
            let presentingViewController = ATYDetailImageViewController(image: image)
            present(presentingViewController, animated: true)
        }
    }

    func didSelect(image: UIImage?, withPath path: String?) {
        
        print("Selected path = \(path)")
        viewModel.input.avatarPath(path)
        
        if let newImage = image {
            self.image = newImage
            self.photoImageView.image = newImage
            self.addPhotoButton.setTitle(R.string.localizable.uploadAnotherPhoto(), for: .normal)
        }
    }
}
