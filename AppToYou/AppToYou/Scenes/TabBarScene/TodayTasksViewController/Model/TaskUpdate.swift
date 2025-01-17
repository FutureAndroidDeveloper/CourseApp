import Foundation


/**
 Набор доступных обновлений задач в списке задач.
 */
enum TaskUpdate {
    /**
     Вставить задачу в список.
     */
    case insert
    
    /**
     Удалить задачу из списка.
     */
    case remove
    
    /**
     Обновить состояние задачи в списке.
     */
    case reload
}
