import UIKit


/**
 Представление прогресса ячейки для задачи подсчета повторений.
 */
class CountTaskProgressView: TaskProgressView {
    
    /**
     Представление, которое отвечает за отображение текущего прогресса ячейки.
     
     Иcпользуется реализация с использованием отображения текста.
     */
    override var progressView: ProgressView {
        return labelProgressView
    }
    
    private let labelProgressView = LabelProgressView()
}
