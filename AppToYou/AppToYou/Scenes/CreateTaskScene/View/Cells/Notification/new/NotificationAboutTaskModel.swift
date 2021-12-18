import Foundation


/**
 Модель ячейки напоминания о задаче.
 */
class NotificationAboutTaskModel {
    /**
     Обработчик переключения активации уведомлений о задаче.
     */
    let switchCallback: ((Bool) -> Void)
    
    /**
     Обработчик выбора времени для представления получения уведомления о задаче.
     
     - parameters:
        - delegate: объект, который обновляет модель напоминаний о задаче.
     */
    let timerCallback: (_ delegate: TaskNoticationDelegate) -> Void
    
    /**
     Модели представления напоминания о задаче.
     */
    var notificationModels: [NotificationTaskTimeModel]
    
    /**
     Создание модели.
     */
    init(notificationModels: [NotificationTaskTimeModel],
         switchCallback: @escaping (Bool) -> Void,
         timerCallback: @escaping (TaskNoticationDelegate) -> Void) {
        
        self.notificationModels = notificationModels
        self.switchCallback = switchCallback
        self.timerCallback = timerCallback
    }
    
}
