import UIKit


class TaskProgressModel {
    private(set) var state: CurrentStateTask
    private(set) var type: ATYTaskType
    
    init(state: CurrentStateTask, type: ATYTaskType) {
        self.state = state
        self.type = type
    }
    
}

class TaskProgressView: UIView {
    
    private struct Constants {
        static let iconSize = CGSize(width: 30, height: 30)
    }
    
    private var model: TaskProgressModel?
    
    private let progressIcon = UIImageView()
    private let backView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(backView)
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addSubview(progressIcon)
        progressIcon.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Constants.iconSize)
        }
        progressIcon.contentMode = .scaleAspectFit
    }
    
    func configure(with model: TaskProgressModel) {
        var image: UIImage?
        var color: UIColor?
        
        switch model.type {
        case .CHECKBOX:
            image = R.image.checkBoxWithoutBackground()
        case .TEXT:
            image = R.image.text()
        case .TIMER:
            image = R.image.timer()
            if model.state == .performed {
                image = R.image.timerPause()
            } else if model.state == .didNotStart {
                image = R.image.timerStart()
            }
        case .RITUAL:
            backView.draw(value: 37)
        }
        
        
        switch model.state {
        case .didNotStart:
            color = R.color.backgroundButtonCard()
        case .performed:
            color = R.color.textColorSecondary()
        case .done:
            color = R.color.succesColor()
        case .failed:
            color = R.color.failureColor()
        }
        
        backView.backgroundColor = color
        progressIcon.image = image
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    
    
}
