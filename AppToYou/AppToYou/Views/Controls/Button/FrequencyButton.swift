import UIKit


class FrequencyButton: UIButton {
    
    private struct Constants {
        static let insets = UIEdgeInsets(top: 7, left: 10, bottom: 8, right: 13)
        static let imagePadding: CGFloat = 10
    }
    
    private(set) var type: Frequency
    
    
    init(type: Frequency) {
        self.type = type
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    
    private func setup() {
        setImage(R.image.unselectedRadioButton(), for: .normal)
        setImage(R.image.selectedRadioButton(), for: .selected)
        
        setTitle(R.string.localizable.monthly(), for: .normal)
        setTitleColor(R.color.titleTextColor(), for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        backgroundColor = R.color.backgroundTextFieldsColor()
        
        setInsets(contentPadding: Constants.insets, imageTitlePadding: Constants.imagePadding)
    }
    
}
