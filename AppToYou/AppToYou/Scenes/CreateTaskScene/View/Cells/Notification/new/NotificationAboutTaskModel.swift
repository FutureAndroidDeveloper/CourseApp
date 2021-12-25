import Foundation


/**
 Модель ячейки напоминания о задаче.
 */
class NotificationAboutTaskModel: ValidatableModel {
    /**
     Модели представления напоминания о задаче.
     */
    private(set) var notificationModels: [NotificationTaskTimeModel]
    private(set) var isEnabled: Bool
    
    /**
     Обработчик выбора времени для представления получения уведомления о задаче.
     
     - parameters:
        - delegate: объект, который обновляет модель напоминаний о задаче.
     */
    let timerCallback: (_ delegate: TaskNoticationDelegate) -> Void
    var errorNotification: ((CheckboxTaskError?) -> Void)?
    
    /**
     Создание модели.
     */
    init(notificationModels: [NotificationTaskTimeModel],
         isEnabled: Bool,
         timerCallback: @escaping (TaskNoticationDelegate) -> Void) {
        
        self.notificationModels = notificationModels
        self.isEnabled = isEnabled
        self.timerCallback = timerCallback
    }
    
    func add(notification: NotificationTaskTimeModel) {
        notificationModels.append(notification)
    }

    func setIsEnabled(_ isEnabled: Bool) {
        self.isEnabled = isEnabled
    }
    
}
