import Foundation


/**
 Протокол, который сообщает о получении нового напоминания о задаче.
 */
protocol TaskNoticationDelegate: AnyObject {
    
    /**
     Уведомляет о получении нового напоминая о задаче.
     
     - parameters:
        - notification: напоминание о задаче.
     */
    func notificationDidAdd(_ notifcation: NotificationTaskTimeView)
}
