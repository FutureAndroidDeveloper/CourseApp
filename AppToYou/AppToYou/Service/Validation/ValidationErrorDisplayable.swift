import UIKit


// Все, кто может обработать ошибку валидации (UI и модель)
// Используется для смены UI в зависимочти от ошибки
protocol ValidationErrorDisplayable {
    func bind(error: ValidationError?)
}

// Реализация по умолчанию для UIView
// Устанавливает сообщение в нижней части представления
extension ValidationErrorDisplayable where Self: UIView {
    
    func bind(error: ValidationError?) {
        if let errorLabel = viewWithTag(LabelFactory.errorTag) as? UILabel {
            errorLabel.text = error?.message
        } else {
            let errorLabel = LabelFactory.getErrorLabel()
            errorLabel.text = error?.message
            addSubview(errorLabel)
            errorLabel.snp.makeConstraints {
                $0.leading.trailing.bottom.equalToSuperview().inset(LabelFactory.errorInsets)
            }
        }
    }
    
}
