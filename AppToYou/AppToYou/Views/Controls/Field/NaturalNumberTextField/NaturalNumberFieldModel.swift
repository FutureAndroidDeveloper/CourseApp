import Foundation


class NaturalNumberFieldModel: BaseFieldModel<Int> {
    
    private struct Constants {
        static let defaultValue = 0
    }
    
    /**
     Создание модели со значениями по умолчанию.

     Значения по умолчанию - `0`.
     */
    convenience init() {
        self.init(value: Constants.defaultValue)
    }
    
    /**
     Создание модели.

     - parameters:
        - value: начальное натуральное число.
        - placeholder: плейсхолдер поля. Значение по умолчанию - `0`.
     */
    override init(value: Int, placeholder: String? = nil) {
        let placeholder = placeholder == nil ? String(Constants.defaultValue) : placeholder
        super.init(value: value, placeholder: placeholder)
    }
    
}
