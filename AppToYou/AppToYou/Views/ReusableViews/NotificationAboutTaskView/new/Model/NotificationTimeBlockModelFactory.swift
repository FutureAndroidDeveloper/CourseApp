import Foundation


class NotificationTimeBlockModelFactory {
    
    private struct Constants {
        static let hourUnit = R.string.localizable.hour()
        static let minUnit = R.string.localizable.min()
    }

    /**
     Получить модель блока часов. Начальное значение - `0`
     */
    static func getHourModel() -> NotificationTimeBlockModel {
        return NotificationTimeBlockModel(unit: Constants.hourUnit)
    }
    
    /**
     Получить модель блока минут. Начальное значение - `0`
     */
    static func getMinModel() -> NotificationTimeBlockModel {
        return NotificationTimeBlockModel(unit: Constants.minUnit)
    }
}
