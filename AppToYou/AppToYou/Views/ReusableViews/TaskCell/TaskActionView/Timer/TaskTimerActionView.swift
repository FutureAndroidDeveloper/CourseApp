import UIKit


/**
 Представление действий над задачей с таймером.
 
 Не предоставляет активных действий, но требуется для отображения таймера.
 */
class TaskTimerActionView: UIView, TaskActionView {
    private let timerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: TaskActionModel) {
        guard let configuration = model.getConfiguration() as? TimerActionConfiguration else {
            return
        }
        timerLabel.text = configuration.timerValue
        timerLabel.textColor = configuration.color
        timerLabel.isHidden = configuration.isHidden
    }
    
    
    private func setup() {
        addSubview(timerLabel)
        timerLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}
