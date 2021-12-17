import Foundation


class DateFieldModel: BaseFieldModel<Date> {
    
    private struct Constants {
        static let defaultValue = Date()
    }
    
    /**
     Создание модели со значениями по умолчанию.

     Значения по умолчанию - Текущая дата.
     */
    convenience init() {
        self.init(value: Constants.defaultValue)
    }
    
    /**
     Создание модели.

     - parameters:
        - value: начальная дата.
        - placeholder: плейсхолдер поля. Значение по умолчанию - пустое.
     */
    override init(value: Date, placeholder: String? = nil) {
        super.init(value: value, placeholder: placeholder)
    }
}
