import Foundation


class TaskDurationCellModel {
    let durationModel: TaskDurationModel
    
    /**
     Обработчик выбора времени для представления длительности выполнения задачи.
     */
    let timerCallback: () -> Void
    
    init(durationModel: TaskDurationModel, timerCallback: @escaping () -> Void) {
        self.durationModel = durationModel
        self.timerCallback = timerCallback
    }
    
}
