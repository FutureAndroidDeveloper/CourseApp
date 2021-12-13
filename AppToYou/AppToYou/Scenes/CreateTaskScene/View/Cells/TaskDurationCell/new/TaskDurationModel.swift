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
        - durationTime: модель времени выполнения задачи.
     */
    convenience init(durationTime: DurationTime) {
        let hour = TimeBlockModelFactory.getHourModel()
        let min = TimeBlockModelFactory.getMinModel()
        let sec = TimeBlockModelFactory.getSecModel()

        hour.update(value: durationTime.hour)
        min.update(value: durationTime.min)
        sec.update(value: durationTime.sec)
        self.init(hourModel: hour, minModel: min, secModel: sec)
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
    
}
