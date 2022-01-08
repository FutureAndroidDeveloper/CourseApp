import UIKit


/**
 Представление блока времени, которое содержит значение и единицу измерения.
 */
class TimeBlockView: UIView, ValidationErrorDisplayable {
    
    private struct Constants {
        static let padding = UIEdgeInsets(top: 11, left: 16, bottom: 13, right: 10)
    }
    
    /**
     Значение
     */
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.titleTextColor()
        return label
    }()
    
    /**
     Единица измерения
     */
    private let unitLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.titleTextColor()
        return label
    }()
    
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height / 2
    }
    
    private func setup() {
        addSubview(valueLabel)
        valueLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview().inset(Constants.padding)
        }
        
        addSubview(unitLabel)
        unitLabel.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview().inset(Constants.padding)
        }
    }
    
    /**
     Конфигурирует объект переданной моделью.
     
     - parameters:
        - model: модель блока времени.
     */
    func configure(with model: TimeBlockModel) {
        valueLabel.text = model.value
        unitLabel.text = model.unit
    }
    
    func bind(error: ValidationError?) {
        if let _ = error {
            layer.borderWidth = 1
            layer.borderColor = R.color.failureColor()?.cgColor
        } else {
            layer.borderWidth = 0
            layer.borderColor = nil
        }
    }
    
    func updateStyle(_ style: FieldStyle) {
        backgroundColor = style.backgroundColor
        valueLabel.textColor = style.textColor
        unitLabel.textColor = style.textColor
    }
}
