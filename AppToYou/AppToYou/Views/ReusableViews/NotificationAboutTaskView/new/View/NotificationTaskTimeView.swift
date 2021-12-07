import UIKit


/**
 Представление времени получения уведомления о задаче.
 */
class NotificationTaskTimeView: UIView {
        
    private struct Constants {
        static let blockSize = CGSize(width: 85, height: 44)
        static let spacing: CGFloat = 12
    }
        
    private let hourTimeView = NotificationTimeBlockView()
    private let minTimeView = NotificationTimeBlockView()
    
    private(set) var model: NotificationTaskTimeModel
    
    
    init(model: NotificationTaskTimeModel) {
        self.model = model
        super.init(frame: .zero)
        setup()
        configure(with: model)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = R.color.backgroundAppColor()
        
        addSubview(hourTimeView)
        hourTimeView.snp.makeConstraints {
            $0.size.equalTo(Constants.blockSize)
            $0.leading.top.bottom.equalToSuperview()
        }
        
        addSubview(minTimeView)
        minTimeView.snp.makeConstraints {
            $0.size.equalTo(Constants.blockSize)
            $0.trailing.top.bottom.equalToSuperview()
            $0.leading.equalTo(hourTimeView.snp.trailing).offset(Constants.spacing)
        }
    }

    /**
     Конфигурация представления переданной моделью.
     
     - parameters:
        - model: модель представления времени напоминания о задаче.
     */
    func configure(with model: NotificationTaskTimeModel) {
        hourTimeView.configure(with: model.hourModel)
        minTimeView.configure(with: model.minModel)
        self.model = model
    }
    
}

