import Foundation


/**
 Модель представления времени напоминания о задаче.
 */
class NotificationTaskTimeModel: Equatable {
    /**
     Модель - часы получения уведомления.
     */
    let hourModel: TimeBlockModel
    
    /**
     Модель - минуты получения уведомления.
     */
    let minModel: TimeBlockModel
    
    /**
     Является ли модель со значениями по умолчанию.
     
     Часы и минуты в модели по умолчанию - `0`.
     */
    var isDefault: Bool {
        return hourModel.isDefault && minModel.isDefault
    }
    
    /**
     Создание модели.
     
     - parameters:
        - notificationTime: модель времени.
     */
    convenience init(notificationTime: NotificationTime) {
        let hour = TimeBlockModelFactory.getHourModel()
        let min = TimeBlockModelFactory.getMinModel()
        
        hour.update(value: notificationTime.hour)
        min.update(value: notificationTime.min)
        self.init(hourModel: hour, minModel: min)
    }
    
    /**
     Создание модели.
     
     - parameters:
        - hourModel: модель блока часов.
        - minModel: модель юлока минут.
     */
    init(hourModel: TimeBlockModel, minModel: TimeBlockModel) {
        self.hourModel = hourModel
        self.minModel = minModel
    }
    
    static func == (lhs: NotificationTaskTimeModel, rhs: NotificationTaskTimeModel) -> Bool {
        lhs.hourModel.value == rhs.hourModel.value && lhs.minModel.value == rhs.minModel.value
    }
    
}
