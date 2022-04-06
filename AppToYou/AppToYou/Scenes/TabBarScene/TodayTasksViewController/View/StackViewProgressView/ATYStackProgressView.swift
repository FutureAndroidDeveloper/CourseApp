import UIKit


class ATYStackProgressView: UIView {
    private struct Constants {
        static let spacing: CGFloat = 5
    }
    
    private let stackView = UIStackView()
    private var progressViews = [UIView]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.spacing
    }
    
    func update(states: [TaskProgress] = []) {
        stackView.removeFullyAllArrangedSubviews()
        
        progressViews = states.map { state -> UIView in
            var backColor: UIColor?
            
            switch state {
            case .notStarted:
                backColor = R.color.backgroundButtonCard()
            case .done:
                backColor = R.color.succesColor()
            case .inProgress:
                backColor = R.color.textColorSecondary()
            case .failed:
                backColor = R.color.failureColor()
            }
            
            let progressView = UIView()
            progressView.backgroundColor = backColor
            return progressView
        }
        
        progressViews.forEach {
            self.stackView.addArrangedSubview($0)
        }
        layoutSubviews()
    }
    
}
