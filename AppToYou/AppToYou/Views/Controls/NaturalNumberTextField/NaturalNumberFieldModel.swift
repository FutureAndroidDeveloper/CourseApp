import Foundation


class NaturalNumberFieldModel {
    
    private struct Constants {
        static let defaultValue = 0
    }
    
    private(set) var value: Int
    let placeholder: String
    
    /**
     Создание модели со значениями по умолчанию.
     
     Значения по умолчанию - `0`.
     */
    convenience init() {
        self.init(value: Constants.defaultValue, placeholder: nil)
    }

    /**
     Создание модели.
     
     - parameters:
        - value: начальное натуральное число.
        - placeholder: плейсхолдер поля. Значение по умолчанию - `0`.
     */
    init(value: Int, placeholder: String? = nil) {
        self.value = value
        
        if let placeholder = placeholder {
            self.placeholder = placeholder
        } else {
            self.placeholder = String(Constants.defaultValue)
        }
    }

    func update(value: Int) {
        self.value = value
    }
    
}
