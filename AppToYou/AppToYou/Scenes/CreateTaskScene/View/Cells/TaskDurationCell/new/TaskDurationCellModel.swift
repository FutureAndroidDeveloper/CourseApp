import Foundation


class TaskDurationCellModel: ValidatableModel {
    let durationModel: TaskDurationModel
    
    /**
     Обработчик выбора времени для представления длительности выполнения задачи.
     */
    let timerCallback: () -> Void
    
    var errorNotification: ((CommonValidationError.Duration?) -> Void)?
    
    init(durationModel: TaskDurationModel, timerCallback: @escaping () -> Void) {
        self.durationModel = durationModel
        self.timerCallback = timerCallback
    }
    
}
