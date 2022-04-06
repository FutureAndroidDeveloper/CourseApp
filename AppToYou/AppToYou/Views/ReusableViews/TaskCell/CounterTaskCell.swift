import UIKit


/**
 Ячейка задачи на подсчет повторений.
 */
class CounterTaskCell: TaskCell {
    override var progressView: TaskProgressView {
        return countProgressView
    }
    
    override var actionView: TaskActionView? {
        return countActionView
    }
    
    private let countProgressView = CountTaskProgressView()
    private let countActionView = TaskCounterActionView()
}
