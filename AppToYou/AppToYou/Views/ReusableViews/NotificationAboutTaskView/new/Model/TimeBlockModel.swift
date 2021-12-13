import Foundation


/**
 Базовая модель блока времени уведомления.
 */
class TimeBlockModel {
    
    private struct Constants {
        static let defaultValue = "0"
    }
    
    /**
     Значение.
     */
    private(set) var value: String
    
    /**
     Единица измерения.
     */
    let unit: String
    
    /**
     Является ли модель со значением по умолчанию.
     */
    var isDefault: Bool {
        return value == Constants.defaultValue
    }
    
    /**
     Создание модели блока времени.
     
     - parameters:
        - value: значение. Значение по умолчанию - `0`
        - unit: единица измерения.
     */
    init(value: String = Constants.defaultValue, unit: String) {
        self.value = value
        self.unit = unit
    }
    
    /**
     Обновить значение модели.
     
     - parameters:
        - value: новое значение.
     */
    func update(value: String) {
        self.value = value
    }
    
}
