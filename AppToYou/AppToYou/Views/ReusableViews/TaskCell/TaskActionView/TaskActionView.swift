import UIKit


/**
 Протокол конфигурации представления действий над задачей.
 */
protocol TaskActionView: UIView {
    /**
     Сконфигурировать представление с помощью модели действия.
     */
    func configure(with model: TaskActionModel)
}
