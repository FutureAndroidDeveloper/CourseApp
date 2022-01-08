import Foundation


class TaskDurationCellModel: ValidatableModel {
    let durationModel: TaskDurationModel
    let lockModel: LockButtonModel?
    
    /**
     Обработчик выбора времени для представления длительности выполнения задачи.
     */
    let timerCallback: () -> Void
    
    private(set) var style: FieldStyle = StyleManager.standartTextField
    private(set) var isActive: Bool = true
    var errorNotification: ((CommonValidationError.Duration?) -> Void)?
    
    init(durationModel: TaskDurationModel, lockModel: LockButtonModel?, timerCallback: @escaping () -> Void) {
        self.durationModel = durationModel
        self.lockModel = lockModel
        self.timerCallback = timerCallback
    }
    
    func updateActiveState(_ isActive: Bool) {
        self.isActive = isActive
    }
    
    func updateStyle(_ style: FieldStyle) {
        self.style = style
    }
    
}
