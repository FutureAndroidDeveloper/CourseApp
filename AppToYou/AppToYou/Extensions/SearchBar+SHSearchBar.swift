//
//  SearchBar+SHSearchBar.swift
//  AppToYou
//
//  Created by Philip Bratov on 10.08.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import SHSearchBar
import UIKit

// MARK: - Helper Functions

func defaultSearchBar(withRasterSize rasterSize: CGFloat,
                      leftView: UIView?,
                      rightView: UIView?,
                      delegate: SHSearchBarDelegate,
                      useCancelButton: Bool = true, placeholder: String) -> SHSearchBar {

    var config = defaultSearchBarConfig(rasterSize)
    config.leftView = leftView
    config.rightView = rightView
    config.useCancelButton = useCancelButton

    if leftView != nil {
        config.leftViewMode = .always
    }

    if rightView != nil {
        config.rightViewMode = .unlessEditing
    }

    let bar = SHSearchBar(config: config)
    bar.delegate = delegate
    bar.placeholder = NSLocalizedString(placeholder, comment: "")
    bar.updateBackgroundImage(withRadius: 20, corners: [.allCorners], color: UIColor.white)
    return bar
}

func defaultSearchBarConfig(_ rasterSize: CGFloat) -> SHSearchBarConfig {
    var config: SHSearchBarConfig = SHSearchBarConfig()
    config.cancelButtonTitle = "Отменить"
    config.rasterSize = rasterSize
//    config.cancelButtonTitle = NSLocalizedString("sbe.general.cancel", comment: "")
    config.cancelButtonTextAttributes = [.foregroundColor: UIColor.darkGray]
    config.textContentType = UITextContentType.fullStreetAddress.rawValue
    config.textAttributes = [.foregroundColor: UIColor.gray]
    return config
}

func imageViewWithIcon(_ icon: UIImage, raster: CGFloat) -> UIView {
    let imgView = UIImageView(image: icon)
    imgView.translatesAutoresizingMaskIntoConstraints = false

    imgView.contentMode = .center
    imgView.tintColor = UIColor(red: 0.75, green: 0, blue: 0, alpha: 1)

    let container = UIView()
    container.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: raster, bottom: 0, trailing: raster)
    container.addSubview(imgView)

    NSLayoutConstraint.activate([
        imgView.leadingAnchor.constraint(equalTo: container.layoutMarginsGuide.leadingAnchor),
        imgView.trailingAnchor.constraint(equalTo: container.layoutMarginsGuide.trailingAnchor),
        imgView.topAnchor.constraint(equalTo: container.layoutMarginsGuide.topAnchor),
        imgView.bottomAnchor.constraint(equalTo: container.layoutMarginsGuide.bottomAnchor)
    ])

    return container
}
