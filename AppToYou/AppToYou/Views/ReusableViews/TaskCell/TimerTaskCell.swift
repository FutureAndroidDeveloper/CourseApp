import Foundation


/**
 Ячейка задачи с таймером.
 */
class TimerTaskCell: TaskCell {
    override var actionView: TaskActionView? {
        return timerActionView
    }
    
    private let timerActionView = TaskTimerActionView()
}
