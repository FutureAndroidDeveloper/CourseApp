import Foundation


class TaskDurationCellModel: ValidatableModel {
    let durationModel: TaskDurationModel
    let lockModel: LockButtonModel?
    
    /**
     Обработчик выбора времени для представления длительности выполнения задачи.
     */
    let timerCallback: () -> Void
    
    var errorNotification: ((CommonValidationError.Duration?) -> Void)?
    
    init(durationModel: TaskDurationModel, lockModel: LockButtonModel?, timerCallback: @escaping () -> Void) {
        self.durationModel = durationModel
        self.lockModel = lockModel
        self.timerCallback = timerCallback
    }
    
}
