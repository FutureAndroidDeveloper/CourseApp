import UIKit


class WeekdayButton: UIButton {
    
    private let model: WeekdayModel
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? R.color.textColorSecondary() : R.color.backgroundTextFieldsColor()
        }
    }
    
    init(model: WeekdayModel) {
        self.model = model
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
        addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        setTitleColor(R.color.textSecondaryColor(), for: .normal)
        setTitleColor(R.color.backgroundTextFieldsColor(), for: .selected)
        setTitle(model.title, for: .normal)
        isSelected = model.isSelected
    }
    
    func getModel() -> WeekdayModel {
        return model
    }
    
    @objc
    private func buttonAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        model.chandeSelectedState(sender.isSelected)
    }
    
}
