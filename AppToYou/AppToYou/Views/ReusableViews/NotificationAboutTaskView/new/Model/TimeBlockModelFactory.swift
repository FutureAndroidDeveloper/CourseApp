import Foundation


class TimeBlockModelFactory {
    
    private struct Constants {
        static let hourUnit = R.string.localizable.hour()
        static let minUnit = R.string.localizable.min()
        static let secUnit = R.string.localizable.sec()
    }

    /**
     Получить модель блока часов. Начальное значение - `0`
     */
    static func getHourModel() -> TimeBlockModel {
        return TimeBlockModel(unit: Constants.hourUnit)
    }
    
    /**
     Получить модель блока минут. Начальное значение - `0`
     */
    static func getMinModel() -> TimeBlockModel {
        return TimeBlockModel(unit: Constants.minUnit)
    }
    
    /**
     Получить модель блока секунд. Начальное значение - `0`
     */
    static func getSecModel() -> TimeBlockModel {
        return TimeBlockModel(unit: Constants.secUnit)
    }
}
