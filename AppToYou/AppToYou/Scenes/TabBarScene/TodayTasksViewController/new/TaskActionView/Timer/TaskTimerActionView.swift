import UIKit


class TaskTimerActionView: UIView {
    
    private var model: TaskTimerActionModel?
    private let timerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: TaskTimerActionModel) {
        self.model = model
        
        model.updateTimer = { [weak self] value in
            self?.timerLabel.text = value
        }
    }
    
    
    private func setup() {
        addSubview(timerLabel)
        timerLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}
