import UIKit


class ButtonFactory {
    
    private struct Constants {
        static let lockButtonSize = CGSize(width: 24, height: 24)
    }
    
    static func getLockButton() -> LockButton {
        let button = LockButton()
        setSize(for: button, size: Constants.lockButtonSize)
        return button
    }
    
    static func setSize(for button: UIView, size: CGSize) {
        button.snp.makeConstraints {
            $0.size.equalTo(size)
        }
    }
    
}
