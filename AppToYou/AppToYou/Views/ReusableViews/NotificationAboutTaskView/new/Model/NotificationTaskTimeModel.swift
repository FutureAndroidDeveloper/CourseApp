import Foundation


/**
 Модель представления времени напоминания о задаче.
 */
class NotificationTaskTimeModel {
    /**
     Модель - часы получения уведомления.
     */
    let hourModel: NotificationTimeBlockModel
    
    /**
     Модель - минуты получения уведомления.
     */
    let minModel: NotificationTimeBlockModel
    
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
        let hour = NotificationTimeBlockModelFactory.getHourModel()
        let min = NotificationTimeBlockModelFactory.getMinModel()
        
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
    init(hourModel: NotificationTimeBlockModel, minModel: NotificationTimeBlockModel) {
        self.hourModel = hourModel
        self.minModel = minModel
    }
    
}
