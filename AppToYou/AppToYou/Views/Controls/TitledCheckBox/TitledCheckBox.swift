import UIKit


class TitledCheckBox: UIView {
    
    private struct Constant {
        static let spacing: CGFloat = 8
    }
    
    private var model: TitledCheckBoxModel?
    
    private var checkBoxChanged: ((Bool) -> Void)?
    
    private let checkBox = ATYCheckBox()

    private let checkBoxLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        checkBox.addTarget(self, action: #selector(checkBoxAction), for: .touchUpInside)
        addSubview(checkBox)
        checkBox.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(checkBox.snp.height)
        }
        
        addSubview(checkBoxLabel)
        checkBoxLabel.snp.makeConstraints {
            $0.leading.equalTo(checkBox.snp.trailing).offset(Constant.spacing)
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(checkBox)
        }
    }
    
    func configure(with model: TitledCheckBoxModel, _ checkBoxChanged: @escaping (Bool) -> Void) {
        self.model = model
        self.checkBoxChanged = checkBoxChanged
        
        checkBoxLabel.text = model.title
        checkBox.isSelected = model.isSelected
        
    }
    
    @objc
    private func checkBoxAction() {
        model?.chandeSelectedState(checkBox.isSelected)
        checkBoxChanged?(checkBox.isSelected)
    }
    
}
