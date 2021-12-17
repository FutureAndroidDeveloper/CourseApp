import UIKit

/**
 Базовая модель поля.
 
 Generic `Value` используется для установки разных типов значения поля.
 Например: текстовое поле, поле со занчение даты или числа.
 */
class BaseFieldModel<Value> {
    /**
     Значение поля.
     */
    private(set) var value: Value
    
    /**
     Заполнитель поля.
     */
    let placeholder: String?
    
    
    /**
     Создание модели.
     
     - parameters:
        - value: начальное значение поля.
        - placeholder: заполнитель поля.
     */
    init(value: Value, placeholder: String? = nil) {
        self.value = value
        self.placeholder = placeholder
    }
    
    /**
     Обновление значения поля.
     
     - parameters:
        - value: новое значение.
     */
    func update(value: Value) {
        self.value = value
    }
    
}
