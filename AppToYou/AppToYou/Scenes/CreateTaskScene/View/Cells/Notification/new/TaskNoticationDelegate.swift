import Foundation


/**
 Протокол взаимодействия c напоминаниями о задаче.
 */
protocol TaskNoticationDelegate: AnyObject {
    
    /**
     Уведомляет о получении нового напоминая о задаче.
     
     - parameters:
        - notification: напоминание о задаче.
     */
    func notificationDidAdd(_ notifcation: NotificationTaskTimeModel)
    
    /**
     Получить текущее состояние моделей напоминаний о задаче.
     */
    func getNotificationModels() -> [NotificationTaskTimeModel]
}
