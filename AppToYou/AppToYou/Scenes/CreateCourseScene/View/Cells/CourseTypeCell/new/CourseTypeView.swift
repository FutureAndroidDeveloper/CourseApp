import UIKit


class CourseTypeView: UIView {
    
    private struct Constants {
        static let radioButtonInsets = UIEdgeInsets(top: 3, left: 2, bottom: 0, right: 0)
        static let descriptionOffset: CGFloat = 4
        static let titleOffset: CGFloat = 13
    }
    
    private(set) var model: CourseTypeModel
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = R.color.textSecondaryColor()
        return label
    }()
    
    private let radioButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.unselectedRadioButton(), for: .normal)
        button.setImage(R.image.selectedRadioButton(), for: .selected)
        return button
    }()
    
    
    init(model: CourseTypeModel) {
        self.model = model
        super.init(frame: .zero)
        
        setup()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeSelected(_ isSelected: Bool) {
        radioButton.isSelected = isSelected
    }
    
    private func setup() {
        radioButton.addTarget(self, action: #selector(checkBoxAction), for: .touchUpInside)
        addSubview(radioButton)
        radioButton.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(Constants.radioButtonInsets)
            $0.width.equalTo(radioButton.snp.height)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(radioButton.snp.centerY)
            $0.leading.equalTo(radioButton.snp.trailing).offset(Constants.titleOffset)
            $0.trailing.equalToSuperview()
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.descriptionOffset)
            $0.bottom.trailing.equalToSuperview()
        }
    }
    
    private func configure() {
        titleLabel.text = model.value.title
        descriptionLabel.text = model.value.description
    }
    
    @objc
    private func checkBoxAction() {
        model.courseTypePicked(model.value)
    }
    
}
