import UIKit


/**
 Представление длительности выполнения задачи.
 */
class TaskDurationView: UIView, ValidationErrorDisplayable {
        
    private struct Constants {
        static let blockSize = CGSize(width: 85, height: 45)
        static let spacing: CGFloat = 12
    }
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [hourTimeView, minTimeView, secTimeView])
        stack.axis = .horizontal
        stack.spacing = Constants.spacing
        return stack
    }()
    
    private let hourTimeView = TimeBlockView()
    private let minTimeView = TimeBlockView()
    private let secTimeView = TimeBlockView()
        
    
    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = R.color.backgroundAppColor()
        
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        stackView.arrangedSubviews.forEach { view in
            view.snp.makeConstraints { $0.size.equalTo(Constants.blockSize) }
        }
    }

    /**
     Конфигурация представления переданной моделью.
     
     - parameters:
        - model: модель представления времени выполнения задачи.
     */
    func configure(with model: TaskDurationModel) {
        hourTimeView.configure(with: model.hourModel)
        minTimeView.configure(with: model.minModel)
        secTimeView.configure(with: model.secModel)
    }
    
    func bind(error: ValidationError?) {
        hourTimeView.bind(error: error)
        minTimeView.bind(error: error)
        secTimeView.bind(error: error)
    }
    
}

