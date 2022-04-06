import UIKit


/**
 Протокол конфигурации представления прогресса задачи.
 */
protocol ProgressView: UIView {
    /**
     Сконфигурировать представление с помощью модели прогресса.
     */
    func configure(with model: TaskProgressModel)
}
