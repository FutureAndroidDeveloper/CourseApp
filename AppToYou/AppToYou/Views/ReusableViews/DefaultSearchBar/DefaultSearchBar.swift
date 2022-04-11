import UIKit
import SHSearchBar


/**
 Стандартная поисковая строка приложения.
 */
class DefaultSearchBar: UIView {
    private struct Constants {
        static let cancelTitle = "Отменить"
        static let searchOffset: CGFloat = 10
        static let iconInsets = UIEdgeInsets(top: 0, left: Constants.searchOffset, bottom: 0, right: Constants.searchOffset)
    }
            
    private lazy var searchBar: SHSearchBar = {
        let bar = SHSearchBar(config: searchBarConfig)
        return bar
    }()
    
    private lazy var searchBarConfig: SHSearchBarConfig = {
        var config = SHSearchBarConfig()
        config.cancelButtonTitle = Constants.cancelTitle
        config.rasterSize = Constants.searchOffset
        config.cancelButtonTextAttributes = [.foregroundColor: UIColor.darkGray]
        config.textAttributes = [.foregroundColor: UIColor.gray]
        config.leftView = viewWith(icon: R.image.searchImage())
        config.leftViewMode = .always
        return config
    }()
    
    
    init(placeholder: String?) {
        super.init(frame: .zero)
        searchBar.placeholder = placeholder
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let cornerRaius = bounds.height / 2
        searchBar.updateBackgroundImage(
            withRadius: cornerRaius,
            corners: [.allCorners],
            color: R.color.backgroundTextFieldsColor() ?? .white
        )
    }
    
    private func setup() {
        addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setSearchBarDelegate(_ delegate: SHSearchBarDelegate) {
        searchBar.delegate = delegate
    }
    
    private func viewWith(icon: UIImage?) -> UIView {
        let iconView = UIImageView(image: icon)
        iconView.contentMode = .center
        iconView.tintColor = R.color.iconsTintColor()
        
        let iconContainerView = UIView()
        iconContainerView.addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.iconInsets)
        }

        return iconContainerView
    }
}
