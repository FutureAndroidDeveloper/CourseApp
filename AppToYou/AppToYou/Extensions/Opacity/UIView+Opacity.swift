import UIKit


extension UIView {
    
    func disable() {
        setOpacity(.disabled)
    }
    
    func enable() {
        setOpacity(.enabled)
    }
    
    func setOpacity(_ opacity: Opacity, color: UIColor? = nil) {
        let isEnabled = opacity.value == .zero
        let viewWithColor = getFirstViewWithColor(root: self)
        let viewColor = viewWithColor?.backgroundColor
        
        let opacityColor = color ?? viewColor ?? opacity.color
        
        if let opacityView = subviews.first(where: { $0.tag == opacity.tag }) {
            opacityView.backgroundColor = opacityColor?.withAlphaComponent(opacity.value)
            opacityView.isUserInteractionEnabled = !isEnabled
            bringSubviewToFront(opacityView)
        } else {
            let opacityView = UIView()
            opacityView.isUserInteractionEnabled = !isEnabled
            opacityView.tag = opacity.tag
            opacityView.backgroundColor = opacityColor?.withAlphaComponent(opacity.value)
            self.addSubview(opacityView)
            opacityView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            bringSubviewToFront(opacityView)
        }
    }
    
    
    private func getFirstViewWithColor(root view: UIView?) -> UIView? {
        guard let superview = view?.superview, superview.backgroundColor == .clear else {
            return view?.superview
        }
        return getFirstViewWithColor(root: superview)
    }
    
}
