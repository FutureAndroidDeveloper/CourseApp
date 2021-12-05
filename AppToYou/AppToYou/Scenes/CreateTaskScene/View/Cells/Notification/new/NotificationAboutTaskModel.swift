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
        - notification: напоминание о задаче, для которого выбирается время.
        - delegate: получатель уведомления о добавлении нового напоминания.
     */
    let timerCallback: (_ notification: NotificationTaskTimeView, _ delegate: TaskNoticationDelegate) -> Void
    
    /**
     Модели представления напоминания о задаче.
     */
    let notificationModels: [NotificationTaskTimeModel]
    
    /**
     Создание модели.
     */
    init(notificationModels: [NotificationTaskTimeModel],
         switchCallback: @escaping (Bool) -> Void,
         timerCallback: @escaping (NotificationTaskTimeView, TaskNoticationDelegate) -> Void) {
        
        self.notificationModels = notificationModels
        self.switchCallback = switchCallback
        self.timerCallback = timerCallback
    }
    
}
