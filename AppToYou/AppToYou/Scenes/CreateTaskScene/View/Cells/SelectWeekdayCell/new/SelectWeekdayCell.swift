import UIKit


class SelectWeekdayCell: UITableViewCell, InflatableView, ValidationErrorDisplayable {
    
    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 00, left: 20, bottom: 32, right: 20)
        static let buttonHeight: CGFloat = 38
        static let buttonSpacing: CGFloat = 5
    }

    private let buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = Constants.buttonSpacing
        return stack
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
        
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(buttonStack)
        buttonStack.snp.makeConstraints {
            $0.height.equalTo(Constants.buttonHeight)
            $0.edges.equalToSuperview().inset(Constants.edgeInsets)
        }
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? SelectWeekdayModel else {
            return
        }
        
        buttonStack.removeFullyAllArrangedSubviews()
        model.weekdayModels
            .map { WeekdayButton(model: $0) }
            .forEach { self.buttonStack.addArrangedSubview($0) }
        
        model.errorNotification = { [weak self] error in
            self?.bind(error: error)
        }
    }

}
