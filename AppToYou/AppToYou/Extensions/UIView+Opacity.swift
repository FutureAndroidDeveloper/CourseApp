import UIKit


extension UIView {
    
    private struct Constants {
        static let opacityViewTag = 12_48_93_54
        static let opacityColor = R.color.backgroundAppColor()
    }
    
    func setOpacity(_ opacity: CGFloat, color: UIColor? = nil) {
        let opacityColor = color ?? Constants.opacityColor
        let isEnabled = opacity == .zero
        
        if let opacityView = subviews.first(where: { $0.tag == Constants.opacityViewTag }) {
            opacityView.backgroundColor = opacityColor?.withAlphaComponent(opacity)
            opacityView.isUserInteractionEnabled = !isEnabled
        } else {
            let opacityView = UIView()
            opacityView.isUserInteractionEnabled = !isEnabled
            opacityView.tag = Constants.opacityViewTag
            opacityView.backgroundColor = opacityColor?.withAlphaComponent(opacity)
            self.addSubview(opacityView)
            opacityView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
    
}


extension UITableViewCell {
    
    private struct Constants {
        static let enabledOpacity: CGFloat = 0
        static let diabledOpacity: CGFloat = 0.6
    }
    
    func disable() {
        contentView.setOpacity(Constants.diabledOpacity)
    }
    
    func enable() {
        contentView.setOpacity(Constants.enabledOpacity)
    }
}
