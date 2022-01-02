import UIKit


class LockButton: UIButton {
    
    private struct Constants {
        static let lockedImage = R.image.chain()?.withRenderingMode(.alwaysTemplate)
        static let unlockedImage = R.image.unlocked()?.withRenderingMode(.alwaysTemplate)
    }
    
    private var model: LockButtonModel?
    
    private var isLocked: Bool = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        self.imageView?.tintColor = R.color.textColorSecondary()
        self.imageView?.contentMode = .scaleAspectFit
        self.addTarget(self, action: #selector(self.onTap), for: .touchUpInside)
    }
    
    private func lock(_ isLocked: Bool) {
        let image = isLocked ? Constants.lockedImage : Constants.unlockedImage
        setImage(image, for: .normal)
    }
    
    func configure(with model: LockButtonModel) {
        self.model = model
        self.isLocked = !model.isLocked
        
        onTap()
    }
    
    
    @objc
    private func onTap() {
        isLocked.toggle()
        
        lock(isLocked)
        model?.update(isLocked: isLocked)
    }
    
}
