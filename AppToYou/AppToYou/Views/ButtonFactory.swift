import UIKit


class ButtonFactory {
    
    private struct Constants {
        static let lockButtonSize = CGSize(width: 24, height: 24)
        static let standartButtonHeight: CGFloat = 44
        static let transparentButtonHeight: CGFloat = 20
    }
    
    static func getLockButton() -> LockButton {
        let button = LockButton()
        setSize(for: button, size: Constants.lockButtonSize)
        return button
    }
    
    static func getTansparentButton(title: String?) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(R.color.buttonColor(), for: .normal)
        setHeight(for: button, height: Constants.transparentButtonHeight)
        return button
    }
    
    static func getStandartButton(title: String?) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = R.color.buttonColor()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(R.color.backgroundTextFieldsColor(), for: .normal)
        setHeight(for: button, height: Constants.standartButtonHeight)
        return button
    }
    
    static func getProfileImageButton(title: String?) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = R.color.backgroundTextFieldsColor()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(R.color.textColorSecondary(), for: .normal)
        setHeight(for: button, height: Constants.standartButtonHeight)
        return button
    }
    
    static func setSize(for button: UIView, size: CGSize) {
        button.snp.makeConstraints {
            $0.size.equalTo(size)
        }
    }
    
    static func setHeight(for button: UIView, height: CGFloat) {
        button.snp.makeConstraints {
            $0.height.equalTo(height)
        }
    }
    
}
