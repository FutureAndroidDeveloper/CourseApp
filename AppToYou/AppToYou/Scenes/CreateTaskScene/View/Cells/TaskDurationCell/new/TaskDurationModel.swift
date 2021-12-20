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
    
}
