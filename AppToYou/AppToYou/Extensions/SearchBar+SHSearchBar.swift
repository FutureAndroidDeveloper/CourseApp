import SHSearchBar
import UIKit

// MARK: - Helper Functions


func defaultSearchBar(rasterSize: CGFloat, placeholder: String? = nil, leftView: UIView? = nil, rightView: UIView? = nil) -> SHSearchBar {
    var config = defaultSearchBarConfig(rasterSize)
    config.leftView = leftView
    config.rightView = rightView

    if leftView != nil {
        config.leftViewMode = .always
    }

    if rightView != nil {
        config.rightViewMode = .unlessEditing
    }

    let searchBar = SHSearchBar(config: config)
    searchBar.placeholder = placeholder
//    searchBar.updateBackgroundImage(withRadius: 20, corners: [.allCorners], color: UIColor.white)
    searchBar.updateBackgroundImage(withRadius: 1, corners: [.allCorners], color: UIColor.white)
    return searchBar
}

func defaultSearchBarConfig(_ rasterSize: CGFloat) -> SHSearchBarConfig {
    var config = SHSearchBarConfig()
    config.cancelButtonTitle = "Отменить"
    config.rasterSize = rasterSize
    config.cancelButtonTextAttributes = [.foregroundColor: UIColor.darkGray]
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
