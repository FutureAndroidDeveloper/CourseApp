import Foundation


/**
 Модель времени выполнения задачи.
 */
class TaskDurationModel {
    /**
     Часы выполнения задачи.
     */
    let hourModel: TimeBlockModel
    
    /**
     Минуты выполнения задачи.
     */
    let minModel: TimeBlockModel
    
    /**
     Секунды выполнения задачи.
     */
    let secModel: TimeBlockModel
    
    /**
     Является ли модель со значениями по умолчанию.
     
     Часы, минуты и секунды в модели по умолчанию - `0`.
     */
    var isDefault: Bool {
        return hourModel.isDefault && minModel.isDefault && secModel.isDefault
    }
    
    /**
     Создание модели.
     
     - parameters:
        - hourModel: модель блока часов.
        - minModel: модель блока минут.
        - minModel: модель блока секунд.
     */
    init(hourModel: TimeBlockModel, minModel: TimeBlockModel, secModel: TimeBlockModel) {
        self.hourModel = hourModel
        self.minModel = minModel
        self.secModel = secModel
    }
    
    /**
     Обновление модели.
     
     - parameters:
        - durationTime: модель времени выполнения задачи.
     */
    func update(durationTime: DurationTime) {
        hourModel.update(value: durationTime.hour)
        minModel.update(value: durationTime.min)
        secModel.update(value: durationTime.sec)
    }
    
    func getDurationModel() -> Duration? {
        guard
            let day = Int(secModel.value),
            let month = Int(minModel.value),
            let year = Int(hourModel.value)
        else {
            return nil
        }
        return Duration(day: day, month: month, year: year)
    }
}
