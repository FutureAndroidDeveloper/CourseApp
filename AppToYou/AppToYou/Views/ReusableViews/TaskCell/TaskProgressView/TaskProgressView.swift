import UIKit

/**
 Представление прогресса ячейки задачи.
 */
class TaskProgressView: UIView {
    
    /**
     Представление, которое отвечает за отображение текущего прогресса ячейки.
     
     По умолчанию иcпользуется реализация с использованием иконки.
     Для изменения представления необходимо переопределить это свойство в классе наследнике.
     */
    var progressView: ProgressView {
        return imageProgressView
    }
    
    private let imageProgressView = ImageProgressView()
    private var model: TaskProgressModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(with model: TaskProgressModel) {
        self.model = model
        var color: UIColor?
        
        switch model.state {
        case .notStarted:
            color = R.color.backgroundButtonCard()
        case .inProgress:
            color = R.color.textColorSecondary()
        case .done:
            color = R.color.succesColor()
        case .failed:
            color = R.color.failureColor()
        }
        
        progressView.configure(with: model)
        backgroundColor = color
    }
    
    func handleTapAction() {
        model?.executeAction()
    }
}
